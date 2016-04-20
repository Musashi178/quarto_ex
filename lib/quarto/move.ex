defmodule Quarto.Move do
  alias Quarto.{Move, Stone}

  defstruct stone: nil, row: nil, column: nil

  def new_initial_move(%Stone{} = stone) do
    %Move{stone: stone, row: nil, column: nil}
  end

  def new_move(row, column, %Stone{} = stone) when row in 1..4 and column in 1..4 do
    %Move{stone: stone, row: row, column: column}
  end
end
