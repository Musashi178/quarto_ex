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


  @doc ~S"""
   This function converts a stone into it's string equivalent

  ## Examples

    iex> Quarto.Stone.stone_to_string(%Quarto.Stone{size: :small, color: :white, shape: :round, top: :flat})
    "swrf"

    iex> Quarto.Stone.stone_to_string(%Quarto.Stone{size: :large, color: :black, shape: :square, top: :hole})
    "lbsh"
  """
  def stone_to_string(%Quarto.Stone{size: size, color: color, shape: shape, top: top}) do
    [size, color, shape, top]
      |> Enum.map(&Atom.to_char_list/1)
      |> Enum.map(&hd/1)
      |> to_string()
  end

  @doc ~S"""
   This function converts a string into it's stone equivalent

  ## Examples

    iex> Quarto.Stone.string_to_stone("SWrf")
    (%Quarto.Stone{size: :small, color: :white, shape: :round, top: :flat})

    iex> Quarto.Stone.string_to_stone("lbsh")
    %Quarto.Stone{size: :large, color: :black, shape: :square, top: :hole}
  """
  def string_to_stone(stone_string) when is_bitstring(stone_string) do
    lower_stone_string = String.downcase(stone_string)
    %Quarto.Stone{size: nil, color: nil, shape: nil, top: nil}
    |> extract_stone_size(lower_stone_string)
    |> extract_stone_color(lower_stone_string)
    |> extract_stone_shape(lower_stone_string)
    |> extract_stone_top(lower_stone_string)
  end


  defp extract_stone_size(stone, stone_string) do
    size = case String.at(stone_string, 0) do
      "l" -> :large
      "s" -> :small
    end
    %Quarto.Stone{stone | size: size}
  end

  defp extract_stone_color(stone, stone_string) do
    color = case String.at(stone_string, 1) do
      "b" -> :black
      "w" -> :white
    end
    %Quarto.Stone{stone | color: color}
  end

  defp extract_stone_shape(stone, stone_string) do
    shape = case String.at(stone_string, 2) do
      "s" -> :square
      "r" -> :round
    end
    %Quarto.Stone{stone | shape: shape}
  end

  defp extract_stone_top(stone, stone_string) do
    top = case String.at(stone_string, 3) do
      "f" -> :flat
      "h" -> :hole
    end
    %Quarto.Stone{stone | top: top}
  end
end
