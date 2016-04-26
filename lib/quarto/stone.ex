defmodule Quarto.Stone do
  @moduledoc """
  This module represents a stone in the Quarto game with it's four different attributes (size, color, shape, top)
  and also contains helper functions, e.g. computing all stones available in the game
  """
  defstruct size: :small, color: :white, shape: :round, top: :flat

  @doc ~S"""
   This function returns a enum of all 16 stones available in the game. Each stone in it is unique

  ## Examples

    iex> Quarto.Stone.get_all_stones() |> Enum.count
    16

    iex> Quarto.Stone.get_all_stones() |> Enum.uniq |> Enum.count
    16
  """
  def get_all_stones do
    for size <- [:small, :large], color <- [:black, :white], shape <- [:round, :square], top <- [:flat, :hole] do
      %Quarto.Stone{size: size, color: color, shape: shape, top: top}
    end
  end
end
