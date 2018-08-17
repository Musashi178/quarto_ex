defmodule Quarto.Web.SessionsController do
  use Quarto.Web, :controller

  alias Quarto.Accounts
  alias Ueberauth.Strategy.Helpers
  plug Ueberauth

  def new(conn, _params) do
    render(conn, "new.html", callback_url: Helpers.callback_url(conn), current_user: nil)
  end

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    conn
    |> authenticated(Accounts.authenticate_user(auth))
  end

  defp authenticated(conn, {:ok, user}) do
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  defp authenticated(conn, {:error, reason}) do
    conn
    |> put_flash(:error, reason)
    |> redirect(to: "/sessions/new")
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
