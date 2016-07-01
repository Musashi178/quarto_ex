defmodule QuartoWeb.SessionController do
  use QuartoWeb.Web, :controller

  alias QuartoWeb.{UserAuth, User}


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email_or_username" => email_or_username, "password" => password}}) do
    case UserAuth.authenticate(email_or_username, password) do
      {:ok, verified_user} ->
        conn
        |> put_flash(:info, "Logged in.")
        |> Guardian.Plug.sign_in(verified_user)
        |> redirect(to: user_dashboard_path(conn, :index, verified_user))
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid username/password")
        |> render "new.html"
    end


  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end
end
