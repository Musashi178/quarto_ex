defmodule QuartoWeb.GameView do
  use QuartoWeb.Web, :view

  import Ecto.Query, only: [from: 2]

  alias QuartoWeb.{User, Repo}

  def get_available_opponents(%User{id: current_user_id}) do
    query = from u in User,
            where: u.id != ^current_user_id,
            select: u.username

    Repo.all(query)
  end
end
