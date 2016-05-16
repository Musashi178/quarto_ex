defmodule QuartoWeb.PageController do
  use QuartoWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
