defmodule QuartoWeb.GameTest do
  use QuartoWeb.ModelCase

  import QuartoWeb.Factory

  alias QuartoWeb.Game
  alias Ecto.Changeset

  test "game with valid attributes" do
    player_one = insert(:user)
    player_two = insert(:user)

    changeset = %Game{}
      |> Changeset.change()
      |> Changeset.put_assoc(:player_one, player_one)
      |> Changeset.put_assoc(:player_two, player_two)
      |> Game.changeset

    assert {:ok, _game} = Repo.insert changeset
  end

  test "game with player_one not set" do
    player_two = insert(:user)

    changeset = %Game{}
      |> Changeset.change()
      |> Changeset.put_assoc(:player_two, player_two)
      |> Game.changeset

    assert {:error, _changeset} = Repo.insert changeset
  end

  test "game with deleted player" do
    player_one = insert(:user)
    player_two = insert(:user)

    changeset = %Game{}
      |> Changeset.change()
      |> Changeset.put_assoc(:player_one, player_one)
      |> Changeset.put_assoc(:player_two, player_two)
      |> Game.changeset


    {:ok, _} = Repo.delete(player_two)

    assert {:error, _changeset} = Repo.insert changeset
  end
end
