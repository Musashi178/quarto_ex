defmodule Quarto.DSL do
  alias Quarto.{Stone, GameState, Board, Move}

  @doc ~S"""
   This function converts a stone into it's string equivalent

  ## Examples

    iex> Quarto.DSL.stone_to_string(%Quarto.Stone{size: :small, color: :white, shape: :round, top: :flat})
    "swrf"

    iex> Quarto.DSL.stone_to_string(%Quarto.Stone{size: :large, color: :black, shape: :square, top: :hole})
    "lbsh"
  """
  def stone_to_string(%Stone{size: size, color: color, shape: shape, top: top}) do
    [size, color, shape, top]
      |> Enum.map(&Atom.to_char_list/1)
      |> Enum.map(&hd/1)
      |> to_string()
  end

  @doc ~S"""
   This function converts a string into it's stone equivalent

  ## Examples

    iex> Quarto.DSL.string_to_stone("SWrf")
    (%Quarto.Stone{size: :small, color: :white, shape: :round, top: :flat})

    iex> Quarto.DSL.string_to_stone("lbsh")
    %Quarto.Stone{size: :large, color: :black, shape: :square, top: :hole}
  """
  def string_to_stone(stone_string) when is_bitstring(stone_string) do
    lower_stone_string = String.downcase(stone_string)
    %Stone{size: nil, color: nil, shape: nil, top: nil}
    |> extract_stone_size(lower_stone_string)
    |> extract_stone_color(lower_stone_string)
    |> extract_stone_shape(lower_stone_string)
    |> extract_stone_top(lower_stone_string)
  end

  def apply_to_state(state_desc, %GameState{} = state) do
    moves = state_desc
      |> Enum.map(&convert_if_stone_string/1)
      |> Enum.chunk(2, 2, [nil])
      |> Enum.map(&convert_to_move/1)
      |> Enum.reduce(state, fn move, state -> GameState.apply_move(state, move) end)
  end

  defp convert_if_stone_string(stone) when is_bitstring(stone) do
    string_to_stone(stone)
  end

  defp convert_if_stone_string(any) do
    any
  end

  defp convert_to_move([stone, nil]) do
    Move.new_initial_move(stone)
  end

  defp convert_to_move([stone, {row, column}]) do
    Move.new_move(row, column, stone)
  end

  defp extract_stone_size(stone, stone_string) do
    size = case String.at(stone_string, 0) do
      "l" -> :large
      "s" -> :small
    end
    %Stone{stone | size: size}
  end

  defp extract_stone_color(stone, stone_string) do
    color = case String.at(stone_string, 1) do
      "b" -> :black
      "w" -> :white
    end
    %Stone{stone | color: color}
  end

  defp extract_stone_shape(stone, stone_string) do
    shape = case String.at(stone_string, 2) do
      "s" -> :square
      "r" -> :round
    end
    %Stone{stone | shape: shape}
  end

  defp extract_stone_top(stone, stone_string) do
    top = case String.at(stone_string, 3) do
      "f" -> :flat
      "h" -> :hole
    end
    %Stone{stone | top: top}
  end
end
