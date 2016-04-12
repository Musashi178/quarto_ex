defmodule Quarto.Stone do
  defstruct size: :small, color: :white, shape: :round, top: :flat

  def get_all_stones do
    for size <- [:small, :large], color <- [:black, :white], shape <- [:round, :square], top <- [:flat, :hole] do
      %Quarto.Stone{ size: size, color: color, shape: shape, top: top}
    end
  end
end
