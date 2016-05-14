defmodule QuartoTest.GameEngine do
  use ExUnit.Case, async: true
  doctest Quarto.GameEngine

  alias Quarto.GameEngine

  test "new game engine returns an initial game state" do
    {:ok, game_engine} = GameEngine.start_link
    {:ok, game_state} = GameEngine.get_state(game_engine)

    expected_game_state = %Quarto.GameState{}

    assert expected_game_state == game_state
  end

end
