defmodule QuartoWeb.SessionController do
  use QuartoWeb.Web, :controller

  alias QuartoWeb.User


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email_or_username" => email_or_username, "password" => password}}) do
    verified_user = Repo.get_by(User, email: email_or_username) || Repo.get_by(User, username: email_or_username)

    IO.inspect (verified_user)

    conn
    |> put_flash(:info, "Logged in.")
    |> Guardian.Plug.sign_in(verified_user)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end
end
