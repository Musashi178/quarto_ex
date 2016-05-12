defmodule Quarto.Board.WinState do
  @moduledoc """
  This module contains functions to check if the board has a win state or not.

  The basic rule is simple: Have a set of four stones with any attribute being the same, for
  example four black stones, or four small stones.

  These sets are either rows, columns or diagonals, this means there must be a row with those
  equal attributes, or a column, or a diagonals.

  There is also an extended version which takes quadrants into account, but this is not implemented
  yet.
  """

  alias Quarto.Board

  def is_win_state?(board) do
    win_sets = Enum.concat([get_rows(board), get_columns(board), get_diagonals(board)])
    Enum.any?(win_sets, &Quarto.Board.WinState.is_win_line?/1)
  end

  def is_win_line?(stone_line) do
    cond do
      has_empty_field?(stone_line) -> false
      has_unique_attr?(stone_line) -> true
      true -> false
    end
  end

  def has_unique_attr?(stones) do
    Enum.any?(get_unique_attrs(stones))
  end

  def get_unique_attrs(stones) do
    %Quarto.Stone{}
      |> Map.keys
      |> Enum.filter(fn k -> k != :__struct__ end)
      |> Enum.filter(fn attr -> is_unique_attr?(stones, attr) end)
  end

  def is_unique_attr?(stones, attr) do
    num_different_attr = stones |> Enum.uniq_by(fn s -> Map.fetch!(s, attr) end) |> Enum.count
    num_different_attr == 1
  end

  def has_empty_field?(fields) do
    Enum.any?(fields, fn f -> f == nil end)
  end

  def get_rows(board) do
    1..4 |> Enum.map(fn row_index -> Board.get_row(board, row_index) end)
  end

  def get_columns(board) do
    1..4 |> Enum.map(fn column_index -> Board.get_column(board, column_index) end)
  end

  def get_diagonals(board) do
    [:top_down, :bottom_up] |> Enum.map(fn d -> Board.get_diagonal(board, d) end)
  end

end
