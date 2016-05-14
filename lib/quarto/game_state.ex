defmodule Quarto.GameState do
  alias Quarto.Board

  defstruct player: :one, board: %Board{}, stone_to_place: nil
end
