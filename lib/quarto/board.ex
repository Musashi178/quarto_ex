defmodule Quarto.Board do
  defstruct fields: for n <- 0..15, do: nil

  def is_empty?(%Quarto.Board{fields: fields}) do
    Enum.all?(fields, fn f -> f == nil end)
  end

  def set_stone(%Quarto.Board{fields: fields}, row, column, %Quarto.Stone{}) do
  end

  def get_stone(%Quarto.Board{fields: fields}, row, column) do

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
    """
  def compute_index(row, column) do
    ((row-1) * 4) + (column - 1)
  end

end
