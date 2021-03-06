defmodule QuartoEngine.Board do
  @moduledoc """
  This module represents the quarto game board which is a 4 x 4 play field. The internal representation
  is different from that, therefore the module also handles getting and setting stones and has some other
  helper functions.
  """

  alias QuartoEngine.{Board, Stone}

  defstruct fields: for _n <- 0..15, do: nil

  def empty?(%Board{fields: fields}) do
    Enum.all?(fields, fn f -> f == nil end)
  end

  def full?(%Board{fields: fields}) do
    !Enum.member?(fields, nil)
  end

  def field_empty?(%Board{} = board, position) do
    get_stone(board, position) == nil
  end

  @doc ~S"""
   Returns if the given stone has already been placed on the board.

  ## Examples

    iex> board = %QuartoEngine.Board{}
    iex> stone = %QuartoEngine.Stone{size: :small, color: :white, shape: :round, top: :flat}
    iex> new_board = QuartoEngine.Board.set_stone(board, {2, 4}, stone)
    iex> QuartoEngine.Board.stone_set?(new_board, stone)
    true

    iex> board = %QuartoEngine.Board{}
    iex> stone = %QuartoEngine.Stone{size: :small, color: :white, shape: :round, top: :flat}
    iex> QuartoEngine.Board.stone_set?(board, stone)
    false
  """
  def stone_set?(%Board{fields: fields}, stone) do
    Enum.member?(fields, stone)
  end

  def set_stone(%Board{fields: fields} = board, position, %Stone{} = stone) do
    index = compute_index(position)
    %Board{board | fields: List.replace_at(fields, index, stone)}
  end

  def get_stone(%Board{fields: fields}, position) do
    Enum.at(fields, compute_index(position))
  end

  @doc ~S"""
   Compute the index where a specific field is represented in the fields list.
   Row and column must be in the range [1; 4]

  ## Examples

    iex> QuartoEngine.Board.compute_index({1, 1})
    0

    iex> QuartoEngine.Board.compute_index({2, 3})
    6

    iex> QuartoEngine.Board.compute_index({4, 4})
    15

    iex> QuartoEngine.Board.compute_index({5, 0})
    ** (ArgumentError) row (actual: 5 and column (actual: 0) must be in range [1; 4]
  """
  def compute_index({row, column}) when row in 1..4 and column in 1..4 do
    ((row - 1) * 4) + (column - 1)
  end

  def compute_index({row, column}) do
      raise ArgumentError, message: "row (actual: #{row} and column (actual: #{column}) must be in range [1; 4]"
  end

  def get_row(board, row_index) when row_index in 1..4 do
    1..4 |> Enum.map(fn column_index -> get_stone(board, {row_index, column_index}) end)
  end

  def get_column(board, column_index) when column_index in 1..4 do
    1..4 |> Enum.map(fn row_index -> get_stone(board, {row_index, column_index}) end)
  end

  def get_diagonal(board, :top_down) do
    1..4 |> Enum.map(fn index -> get_stone(board, {index, index}) end)
  end

  def get_diagonal(board, :bottom_up) do
    1..4 |> Enum.map(fn index -> get_stone(board, {5 - index, index}) end)
  end
end
