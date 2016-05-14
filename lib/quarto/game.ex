defmodule Quarto.Game do
  alias Quarto.{Stone, Board, GameState, Board.WinState}

  use Fsm, initial_state: :stone_selection, initial_data: %GameState{}

  defstate stone_selection do
   defevent select_stone(%Stone{} = stone), data: game_state do
     case validate_stone(game_state, stone) do
       {:ok, _} -> next_state(:stone_placement, %{game_state | stone_to_place: stone})
       {:error, message} -> raise Quarto.InvalidMoveError, message
     end
   end
 end

 defstate stone_placement do
   defevent place_stone(position), data: game_state do
     case validate_position(game_state, position) do
       {:ok, _} ->
         new_game_state = game_state |> update_board(position) |> switch_players

         cond do
           win_state?(new_game_state) -> next_state(:game_over, %{winner: game_state.player, game_state: new_game_state})
           tie?(new_game_state)       -> next_state(:game_over, %{winner: nil, game_state: new_game_state})
           true                       -> next_state(:stone_selection, new_game_state)
         end
       {:error, message} -> raise Quarto.InvalidMoveError, message
     end
   end
 end

 defstate game_over do
   defevent get_state do

   end

 end

 defp validate_stone(state, stone) do
   if Board.stone_set?(state.board, stone) do
      {:error, "stone is already set"}
    else
      {:ok, stone}
   end
 end

 defp validate_position(state, {row, column} = position) do
   cond do
     not row in 1..4 ->     {:error, "row must be in range 1..4"}
     not column in 1..4 ->  {:error, "column must be in range 1..4"}
     not Board.field_empty?(state.board, position) -> {:error, "field must be empty"}
     true -> {:ok, position}
   end
 end

 defp update_board(state, position) do
   %GameState{state | board: Board.set_stone(state.board, position, state.stone_to_place), stone_to_place: nil}
 end

 defp win_state?(state) do
   WinState.win_state?(state.board)
 end

 defp tie?(state) do
   Board.full?(state.board) and not win_state?(state)
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
