defmodule QuartoTest.Board do
  use ExUnit.Case, async: true
  doctest Quarto.Board

  alias Quarto.Board

  # "setup_all" is called once to setup the case before any test is run
  setup_all do
   initial_board = %Board{}
   full_board = %Board{fields: Quarto.Stone.get_all_stones()}

   # No metadata
   {:ok, initial_board: initial_board, full_board: full_board }
  end

  setup do
   random_stone = Quarto.Stone.get_all_stones() |> Enum.random
   {:ok, random_stone: random_stone, random_column: 1, random_row: 2}
  end

  test "all fields of an initial board are nil" do
    assert Board.is_empty?(%Board{})
  end

  test "set_stone returns a non empty board", %{ initial_board: board, random_row: row, random_column: column, random_stone: stone } do
    result = Board.set_stone(board, row, column, stone)
    refute Board.is_empty?(result)
  end

  test "set_stone returns a board containing the set stone", %{ initial_board: board, random_row: row, random_column: column, random_stone: stone } do
    result = Board.set_stone(board, row, column, stone)
    assert Enum.member?(result.fields, stone)
  end

  test "get_stone returns nil on an empty field", %{ initial_board: board, random_row: row, random_column: column }  do
    stone = Board.get_stone(board, row, column)
    assert stone === nil
  end

  test "get_stone returns stone set", %{ initial_board: board, random_row: row, random_column: column, random_stone: stone} do
    result = board
              |> Board.set_stone(row, column, stone)
              |> Board.get_stone(row, column)

    assert result === stone
  end

  test "get_row with full_board returns 4 elements", %{ full_board: board, random_row: row} do
    result_row = Board.get_row(board, row)
    assert Enum.count(result_row)  === 4
  end

  test "get_column with full_board returns 4 elements", %{ full_board: board, random_column: column} do
    result_column = Board.get_column(board, column)
    assert Enum.count(result_column)  === 4
  end

  test "get_row and get_column with a full_board must have one common element", %{ full_board: board, random_row: row, random_column: column} do
      result_row = Board.get_row(board, row)
      result_column = Board.get_column(board, column)

      stones_in_column_and_row = MapSet.intersection(MapSet.new(result_row), MapSet.new(result_column))

      assert stones_in_column_and_row === MapSet.new([Board.get_stone(board, row, column)])
  end
end