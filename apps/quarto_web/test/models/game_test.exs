defmodule QuartoWeb.GameTest do
  use QuartoWeb.ModelCase

  import QuartoWeb.Factory

  alias QuartoWeb.{Game, User}

  test "game with valid attributes" do
    player_one = insert(:user)
    player_two = insert(:user)

    changeset = %Game{}
      |> Game.changeset
      |> Ecto.Changeset.put_assoc(:player_one, player_one)
      |> Ecto.Changeset.put_assoc(:player_two, player_two)

    assert {:ok, changeset} = Repo.insert changeset
  end
end
