defmodule QuartoTest.GameEngine do
  use ExUnit.Case, async: true
  doctest Quarto.GameEngine

  alias Quarto.GameEngine

  test "new game engine returns an initial game state" do
    assert {:ok, _} = GameEngine.start_link

  end

end
