defmodule Quarto.GameEngine do
  use GenServer

  alias Quarto.{GameState, Stone, Move}

  # Client

  def start_link(continue_state \\ %GameState{}) do
    GenServer.start_link(__MODULE__, continue_state)
  end

  def move(pid, %Stone{} = stone) do
    GenServer.call(pid, {:move, stone})
  end

  def move(pid, row, column, %Stone{} = stone) do
    GenServer.call(pid, {:move, row, column, stone})
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  # Server

  def handle_call({:move, %Stone{} = stone}, _from, state) do
    m = Move.new_initial_move(stone)
    {:ok, new_state} = GameState.apply_move(state, m)
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:move, row, column, %Stone{} = stone}, _from, state) do
    m = Move.new_move(row, column, stone)
    {:ok, new_state} = GameState.apply_move(state, m)
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, {:ok, state}}
  end
end
