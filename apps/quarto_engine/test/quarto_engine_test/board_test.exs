defmodule QuartoEngineTest.Board do
  use ExUnit.Case, async: true
  doctest QuartoEngine.Board

  alias QuartoEngine.{Board, Stone}

  # "setup_all" is called once to setup the case before any test is run
  setup_all do
   initial_board = %Board{}
   full_board = %Board{fields: Stone.get_all_stones()}

   # No metadata
   {:ok, initial_board: initial_board, full_board: full_board }
  end

  setup do
   random_stone = Stone.get_all_stones() |> Enum.random
   {:ok, random_stone: random_stone, random_position: {1, 2}}
  end

  test "all fields of an initial board are nil" do
    assert Board.empty?(%Board{})
  end

  test "set_stone returns a non empty board", %{ initial_board: board, random_position: position, random_stone: stone } do
    result = Board.set_stone(board, position, stone)
    refute Board.empty?(result)
  end

  test "set_stone returns a board containing the set stone", %{ initial_board: board, random_position: position, random_stone: stone } do
    result = Board.set_stone(board, position, stone)
    assert Enum.member?(result.fields, stone)
  end

  test "get_stone returns nil on an empty field", %{ initial_board: board, random_position: position }  do
    stone = Board.get_stone(board, position)
    assert stone === nil
  end

  test "get_stone returns stone set", %{ initial_board: board, random_position: position, random_stone: stone} do
    result = board
              |> Board.set_stone(position, stone)
              |> Board.get_stone(position)

    assert result === stone
  end

  test "get_row with full_board returns 4 elements", %{ full_board: board, random_position: {row, _column}} do
    result_row = Board.get_row(board, row)
    assert Enum.count(result_row)  === 4
  end

  test "get_column with full_board returns 4 elements", %{ full_board: board, random_position: {_row, column}} do
    result_column = Board.get_column(board, column)
    assert Enum.count(result_column)  === 4
  end

  test "get_row and get_column with a full_board must have one common element", %{ full_board: board, random_position: {row, column} = position} do
      result_row = Board.get_row(board, row)
      result_column = Board.get_column(board, column)

      stones_in_column_and_row = MapSet.intersection(MapSet.new(result_row), MapSet.new(result_column))

      assert stones_in_column_and_row === MapSet.new([Board.get_stone(board, position)])
  end
end
