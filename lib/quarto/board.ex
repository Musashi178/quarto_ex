defmodule Quarto.Board do
  defstruct fields: for _n <- 0..15, do: nil

  def is_empty?(%Quarto.Board{fields: fields}) do
    Enum.all?(fields, fn f -> f == nil end)
  end

  def set_stone(%Quarto.Board{fields: fields} = board, row, column, %Quarto.Stone{} = stone) do
    index = compute_index(row, column)
    %Quarto.Board{board | fields: List.replace_at(fields, index, stone)}
  end

  def get_stone(%Quarto.Board{fields: fields}, row, column) do
    Enum.at(fields, compute_index(row, column))
  end

  @doc """
    Compute the index where a specific field is represented in the fields list.
    Row and column must be in the range [1; 4]
    ## Examples
        iex> Quarto.Board.compute_index(1, 1)
        0

        iex> Quarto.Board.compute_index(2, 3)
        6

        iex> Quarto.Board.compute_index(4, 4)
        15

        iex> Quarto.Board.compute_index(5, 0)
        ** (ArgumentError) row and column must be in range [1; 4]
    """
  def compute_index(row, column) when row < 1 or row > 4 or column < 1 or column > 4 do
      raise ArgumentError, message: "row and column must be in range [1; 4]"
  end

  def compute_index(row, column) do
    ((row-1) * 4) + (column - 1)
  end

  def get_row(board, row_index) when row_index in 1..4 do
    1..4 |> Enum.map(fn column_index -> Quarto.Board.get_stone(board, row_index, column_index) end)
  end

  def get_column(board, column_index) when column_index in 1..4 do
    1..4 |> Enum.map(fn row_index -> Quarto.Board.get_stone(board, row_index, column_index) end)
  end

  def get_diagonal(board, :top_down) do
    1..4 |> Enum.map(fn index -> Quarto.Board.get_stone(board, index, index) end)
  end

  def get_diagonal(board, :bottom_up) do
    1..4 |> Enum.map(fn index -> Quarto.Board.get_stone(board, 5 - index, index) end)
  end
end
