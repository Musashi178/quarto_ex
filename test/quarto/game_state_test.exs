defmodule QuartoTest.GameStateTest do
  use ExUnit.Case
  doctest Quarto.GameStateTest

  test "new returns a state with next player is one" do
    assert GameState.new == {}
  end
end
