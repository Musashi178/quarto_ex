defmodule QuartoTest.Board.WinState do
  use ExUnit.Case, async: true
  doctest Quarto.Board.WinState

  alias Quarto.Board
  alias Quarto.Board.WinState

  # "setup_all" is called once to setup the case before any test is run
 setup_all do
   initial_board = %Board{}
   full_board = %Board{fields: Quarto.Stone.get_all_stones()}

   stone_a = %Quarto.Stone{size: :small, color: :white, shape: :round, top: :flat}
   stone_b = %Quarto.Stone{ stone_a | size: :large}
   stone_c = %Quarto.Stone{ stone_a | color: :black}
   stone_d = %Quarto.Stone{ stone_a | shape: :square}
   stone_e = %Quarto.Stone{ stone_a | shape: :square, top: :round}

   win_line = [stone_a, stone_b, stone_c, stone_d]
   non_win_line = [stone_a, stone_b, stone_c, stone_e]

   # No metadata
   {:ok, initial_board: initial_board, full_board: full_board, win_line: win_line, non_win_line: non_win_line }
 end

 setup do
   random_stone = Quarto.Stone.get_all_stones() |> Enum.random
   {:ok, random_stone: random_stone, random_column: 1, random_row: 2}
 end

  test "is_unique_attr? with unique attribute :top returns true", %{win_line: stones} do
    assert WinState.is_unique_attr?(stones, :top)
  end

  test "is_unique_attr? with non-unique attribute :color returns false", %{win_line: stones} do
    refute WinState.is_unique_attr?(stones, :color)
  end

  test "get_unique_attrs with win_line returns :top", %{win_line: stones} do
    assert WinState.get_unique_attrs(stones) == [:top]
  end

  test "get_unique_attrs with non_win_line returns empty list", %{non_win_line: stones} do
    assert WinState.get_unique_attrs(stones) == []
  end

  test "has_unique_attr? with win_line returns true", %{win_line: stones} do
    assert WinState.has_unique_attr?(stones)
  end

  test "has_unique_attr? with non_win_line returns false", %{non_win_line: stones} do
    assert WinState.has_unique_attr?(stones) === false
  end

  test "is_win_line? with win_line returns true", %{win_line: stones} do
    assert WinState.is_win_line?(stones)
  end

  test "is_win_line? with line were not all fields are set returns false", %{win_line: win_line} do
    stones = List.replace_at(win_line, 1, nil)
    assert WinState.is_win_line?(stones) === false
  end

  test "is_win_line? with non_win_line returns false", %{non_win_line: stones} do
    assert WinState.is_win_line?(stones) === false
  end
end
