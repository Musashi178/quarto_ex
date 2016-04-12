defmodule QuartoTest.GameStateTests do
  use ExUnit.Case
  doctest Quarto.GameStateTests

  test "new returns a state with next player is one" do
    assert GameState.new == {}
  end
end
