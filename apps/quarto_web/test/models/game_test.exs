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

  test "for_user" do
    player_one = insert(:user)
    player_two = insert(:user)
    player_three = insert(:user)
    player_four = insert(:user)

    Repo.insert %Game{}
      |> Changeset.change()
      |> Changeset.put_assoc(:player_one, player_one)
      |> Changeset.put_assoc(:player_two, player_two)
      |> Game.changeset

    Repo.insert %Game{}
      |> Changeset.change()
      |> Changeset.put_assoc(:player_one, player_three)
      |> Changeset.put_assoc(:player_two, player_one)
      |> Game.changeset

    games_of_player_one = Game |> Game.for_user(player_one) |> Repo.all
    games_of_player_two = Game |> Game.for_user(player_two) |> Repo.all
    games_of_player_three = Game |> Game.for_user(player_three) |> Repo.all
    games_of_player_four = Game |> Game.for_user(player_four) |> Repo.all

    assert Enum.count(games_of_player_one) == 2
    assert Enum.count(games_of_player_two) == 1
    assert Enum.count(games_of_player_three) == 1
    assert Enum.count(games_of_player_four) == 0
  end

  test "get_other_player" do
    player_one = insert(:user)
    player_two = insert(:user)
    player_three = insert(:user)

    {:ok, game} = Repo.insert %Game{}
      |> Changeset.change()
      |> Changeset.put_assoc(:player_one, player_one)
      |> Changeset.put_assoc(:player_two, player_two)
      |> Game.changeset

    assert {:ok, player_two} == Game.get_other_player(game, player_one)
    assert {:ok, player_one} == Game.get_other_player(game, player_two)
    assert {:error, _msg} = Game.get_other_player(game, player_three)
  end
end
