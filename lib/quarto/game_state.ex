defmodule Quarto.GameState do
  alias Quarto.Board
  alias Quarto.Move
  alias Quarto.GameState
  alias Quarto.Stone

  defstruct player: :one, board: %Board{}, stone_to_set: nil

  @doc """
    valid_move? for an initial game state will only return true if row and column are nil and next_stone is a valid game stone
  """
  def valid_move?(%GameState{stone_to_set: nil}, %Move{row: nil, column: nil, stone: next_stone}) do
    Enum.member?(Stone.get_all_stones, next_stone)
  end

  @doc """
    valid_move? for a non initial game state will only return true if row and column are set and the stones are valid
  """
  def valid_move?(%GameState{stone_to_set: %Stone{} = stone_to_set, board: board}, %Move{row: row, column: column, stone: %Stone{} = next_stone})
    when not is_nil(stone_to_set) and row in 1..4 and column in 1..4 do
      Board.field_empty?(board, row, column)
      and not Board.stone_set?(board, next_stone)
      and stone_to_set != next_stone
      and Enum.member?(Stone.get_all_stones, next_stone)
  end

  def valid_move?(_state, _move) do
    false
  end

  def apply_move(state, move) do
    if valid_move?(state, move) do
      new_state = state
      |> update_board(move.row, move.column)
      |> set_stone_to_set(move.stone)
      |> switch_players
      {:ok, new_state}
    else
      {:error, "Invalid move."}
    end
  end

  defp update_board(state, nil, nil) do
    state
  end

  defp update_board(state, row, column) do
    %GameState{state | board: Board.set_stone(state.board, row, column, state.stone_to_set)}
  end

  defp set_stone_to_set(state, stone) do
    %GameState{state | stone_to_set: stone}
  end

  defp switch_players(state) do
    %GameState{state | player: switch_player(state.player)}
  end

  defp switch_player(:one) do
    :two
  end

  defp switch_player(:two) do
    :one
  end
end
