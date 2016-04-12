defmodule QuartoTest.Stone do
  use ExUnit.Case, async: true
  doctest Quarto.Stone

  alias Quarto.Stone

  test "get_all_stones returns 16 stones" do
    assert Enum.count(Stone.get_all_stones) == 16
  end

  test "get_all_stones returns only unique items" do
    all_stones = Stone.get_all_stones

    assert Enum.count(all_stones) == Enum.count(Enum.uniq(all_stones))
  end
end
