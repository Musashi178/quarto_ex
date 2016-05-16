defmodule Quarto.Engine.GameState do
  alias Quarto.Engine.Board

  defstruct player: :one, board: %Board{}, stone_to_place: nil
end
