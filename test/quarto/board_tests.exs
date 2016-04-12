defmodule QuartoTest.BoardTests do
  use ExUnit.Case
  doctest Quarto.BoardTests

  test "new returns a state with next player is one" do
    assert GameState.new == {}
  end
end
