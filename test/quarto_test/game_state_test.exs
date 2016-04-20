defmodule QuartoTest.GameState do
  use ExUnit.Case, async: true
  doctest Quarto.GameState

  alias Quarto.{GameState, Stone, Move}

  setup_all do
   initial_game_state = %GameState{}

   stone_a = %Stone{size: :small, color: :white, shape: :round, top: :flat}
   stone_b = %Stone{ stone_a | size: :large}
   {:ok, initial_game_state: initial_game_state, stone_a: stone_a, stone_b: stone_b}
  end

  test "new GameState starts with player one" do
    new_game_state = %GameState{}
    assert new_game_state.player == :one
  end

  test "apply_move with a initial move and an initial game state returns ok and the expected game state", %{initial_game_state: initial_game_state, stone_a: stone} do
    move = Move.new_initial_move(stone)

    expected_state = %Quarto.GameState{board: %Quarto.Board{}, stone_to_set: stone, player: :two}
    assert {:ok, expected_state} == GameState.apply_move(initial_game_state, move)
  end

  test "apply_move with a initial move and a not initial game state returns an error", %{initial_game_state: initial_game_state, stone_a: stone_a, stone_b: stone_b} do
    initial_move = Move.new_initial_move(stone_a)
    game_state = GameState.apply_move(initial_game_state, initial_move)
    new_initial_move = Move.new_initial_move(stone_b)

    assert {:error, _message} = GameState.apply_move(game_state, new_initial_move)
  end

  test "apply_move with a non initial move and a initial game state returns an error ", %{initial_game_state: initial_game_state, stone_a: stone} do
    non_initial_move = Move.new_move(1, 1, stone)
    assert {:error, _message} = GameState.apply_move(initial_game_state, non_initial_move)
  end

  test "apply_move with a non initial move and a non initial game state returns ok and the expected state", %{initial_game_state: initial_game_state, stone_a: stone_a, stone_b: stone_b} do
    initial_move = Move.new_initial_move(stone_a)
    next_move =  Move.new_move(1, 1, stone_b)
    game_state = with game_state <- initial_game_state,
                 {:ok, game_state} <- GameState.apply_move(game_state, initial_move),
                 do: GameState.apply_move(game_state, next_move)

    expected_state = %GameState{
      board: %Quarto.Board{fields: [
      stone_a,  nil, nil, nil,
      nil,      nil, nil, nil,
      nil,      nil, nil, nil,
      nil,      nil, nil, nil]},
      player: :one,
      stone_to_set: stone_b}

    assert {:ok, expected_state} = game_state
  end
end
