defmodule QuartoWeb.SessionController do
  use QuartoWeb.Web, :controller

  alias QuartoWeb.User
  alias QuartoWeb.Session

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email_or_username" => email_or_username, "password" => password}}) do
    conn
  end

  def delete(conn, _params) do
    conn
  end
end
