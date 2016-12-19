defmodule QuartoWeb.Game.Move do
  use QuartoWeb.Web, :model

  embedded_schema do
   field :selected_stone
   field :placed_stone_at

   timestamps
  end

end
