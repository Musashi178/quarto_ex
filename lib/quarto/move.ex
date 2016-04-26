defmodule Quarto.Move do
  @moduledoc """
  This module represents the moves in a Quarto game. A move in quarto is made of two steps, one setting
  the already chosen stone to a position on the field (represented by row and column) and one chosing
  a stone that the opponent has to set. There is only one exception that is the initial move where player one
  only chooses a stone for player two to set.
  """
  alias Quarto.{Move, Stone}

  defstruct stone: nil, row: nil, column: nil

  def new_initial_move(%Stone{} = stone) do
    %Move{stone: stone, row: nil, column: nil}
  end

  def new_move(row, column, %Stone{} = stone) when row in 1..4 and column in 1..4 do
    %Move{stone: stone, row: row, column: column}
  end
end
