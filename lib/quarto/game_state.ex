defmodule Quarto.GameState do
  defstruct player: :one

  def new do
    %Quarto.GameState{}
  end
end
