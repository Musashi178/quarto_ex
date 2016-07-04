defmodule QuartoWeb.DashboardView do
  use QuartoWeb.Web, :view

  alias QuartoWeb.{User, Game}

  def get_other_player(current_user, game) do
      {:ok, other_player} = Game.get_other_player(game, current_user)
      other_player
  end
end
