defmodule QuartoTest.Board do
  use ExUnit.Case, async: true
  doctest Quarto.Board

  alias Quarto.Board

  test "all fields of an initial board are nil" do
    assert Board.is_empty?(%Board{})
  end

end
