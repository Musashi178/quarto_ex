defmodule QuartoWeb.GameController do
  use QuartoWeb.Web, :controller

  alias QuartoWeb.{Game, User}
  alias Ecto.Changeset

  plug :scrub_params, "game" when action in [:create, :update]
  plug Guardian.Plug.EnsureAuthenticated, handler: QuartoWeb.UnauthenticatedController

  def index(conn, _params, _user) do
    games = Game |> Repo.all |> Repo.preload([:player_one, :player_two])
    render(conn, "index.html", games: games)
  end

  def new(conn, _params, _user) do
    changeset = Game.changeset(%Game{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game_params}, user) do
    opponent_user = Repo.get_by(User, username: game_params["opponent"])
    {player_one, player_two} = shuffle_players(user, opponent_user)

    changeset = %Game{}
    |> Changeset.change()
    |> Changeset.put_assoc(:player_one, player_one)
    |> Changeset.put_assoc(:player_two, player_two)
    |> Game.changeset

    case Repo.insert(changeset) do
      {:ok, _game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    game = Repo.get!(Game, id)
    render(conn, "show.html", game: game)
  end

  def edit(conn, %{"id" => id}, _user) do
    game = Repo.get!(Game, id)
    changeset = Game.changeset(game)
    render(conn, "edit.html", game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}, _user) do
    game = Repo.get!(Game, id)
    changeset = Game.changeset(game, game_params)

    case Repo.update(changeset) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: game_path(conn, :show, game))
      {:error, changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    game = Repo.get!(Game, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: game_path(conn, :index))
  end

  defp shuffle_players(p_one, p_two) do
    if :rand.uniform() > 0.5 do
      {p_one, p_two}
    else
      {p_two, p_one}
    end
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end
end
