defmodule QuartoWeb.DashboardController do
  use QuartoWeb.Web, :controller

  alias QuartoWeb.{Dashboard, User}

  plug :scrub_params, "dashboard" when action in [:create, :update]

  def index(conn, %{"user_id" => user_id}) do
    render(conn, "index.html")
  end

end
