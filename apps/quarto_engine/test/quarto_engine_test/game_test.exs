defmodule Quarto.EngineTest.Game do
  use ExUnit.Case, async: true
  doctest Quarto.Engine.Game

  alias Quarto.Engine.{Game, Stone, Board}

  setup_all do
   stone_a = %Stone{size: :small, color: :white, shape: :round, top: :flat}
   stone_b = %Stone{stone_a | size: :large}
   {:ok, stone_a: stone_a, stone_b: stone_b}
  end

  test "basic game moves work", %{stone_a: stone_a, stone_b: stone_b} do
    Game.new
    |> Game.select_stone(stone_a)
    |> Game.place_stone({1,1})
    |> Game.select_stone(stone_b)
    |> Game.place_stone({2,1})

  end

  test "selecting a stone on a new game makes this stone the one to place", %{stone_a: stone} do
    game = Game.new |> Game.select_stone(stone)
    assert game.data.stone_to_place == stone
  end

  test "placing a stone puts the stone_to_place on the board", %{stone_a: stone} do
    game = Game.new
      |> Game.select_stone(stone)
      |> Game.place_stone({2,1})

      assert Board.get_stone(game.data.board, {2, 1}) === stone
      assert game.data.stone_to_place === nil
  end

  test "selecting an already set stone fails", %{stone_a: stone} do
    test_game_state = Game.new
                      |> Game.select_stone(stone)
                      |> Game.place_stone({1,1})

    assert_raise Quarto.Engine.InvalidMoveError, fn ->
      Game.select_stone(test_game_state, stone)
    end
  end
end
