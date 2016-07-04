defmodule QuartoWeb.UnauthenticatedController do
  use QuartoWeb.Web, :controller

  def unauthenticated(conn, params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: page_path(conn, :index))
    |> halt()
  end
end
