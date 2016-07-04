defmodule QuartoWeb.DashboardController do
  use QuartoWeb.Web, :controller

  alias QuartoWeb.{Dashboard, User, Game}

  plug :scrub_params, "dashboard" when action in [:create, :update]
  plug Guardian.Plug.EnsureAuthenticated, handler: QuartoWeb.UnauthenticatedController

  def index(conn, %{"user_id" => user_id}) do
    user = Repo.get!(User, user_id)
    games = Game |> Game.for_user(user) |> Repo.all |> Repo.preload([:player_one, :player_two])

    render(conn, "index.html", games: games)
  end

end
