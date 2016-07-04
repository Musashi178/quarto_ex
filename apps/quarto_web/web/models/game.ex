defmodule QuartoWeb.Game do
  use QuartoWeb.Web, :model

  schema "games" do
    belongs_to :player_one, QuartoWeb.User
    belongs_to :player_two, QuartoWeb.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:player_one_id, :player_two_id])
    |> cast_assoc(:player_one, required: true)
    |> cast_assoc(:player_two, required: true)
    |> assoc_constraint(:player_one)
    |> assoc_constraint(:player_two)
  end

  def for_user(query, %QuartoWeb.User{id: user_id}) do
    from g in query,
    where: g.player_one_id == ^user_id or g.player_two_id == ^user_id
  end

  def get_other_player(%QuartoWeb.Game{} = game, %QuartoWeb.User{id: user_id}) do
    cond do
      game.player_one_id == user_id -> {:ok, game.player_two}
      game.player_two_id == user_id -> {:ok, game.player_one}
      true -> {:error, "Player #{user_id} is not part of that game"}
    end
  end
end
