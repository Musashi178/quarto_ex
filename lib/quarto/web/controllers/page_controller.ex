defmodule Quarto.Web.PageController do
  use Quarto.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
