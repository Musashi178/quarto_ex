defmodule QuartoEngine.GameState do
  alias QuartoEngine.Board

  defstruct player: :one, board: %Board{}, stone_to_place: nil
end
