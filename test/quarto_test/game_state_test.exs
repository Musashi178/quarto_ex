defmodule QuartoTest.GameState do
  use ExUnit.Case, async: true
  doctest Quarto.GameState

  alias Quarto.GameState

  test "new GameState starts with player one" do
    new_game_state = %GameState{}
    assert new_game_state.player == :one
  end

end
