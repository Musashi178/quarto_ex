defmodule QuartoTest.DSL do
  use ExUnit.Case, async: true
  doctest Quarto.DSL

  alias Quarto.{DSL, Stone}

  test "apply_to_state" do
    expected_state = %Quarto.GameState{player: :two, stone_to_set: %Stone{size: :large, color: :black, shape: :square, top: :hole}}
    state_desc = [ "lbsh" ]
    result_state = DSL.apply_to_state(state_desc, %Quarto.GameState{})

    assert {:ok, expected_state} === result_state
  end
end
