defmodule Quarto.Web.SessionsController do
  use Quarto.Web, :controller

  alias Quarto.Accounts
  alias Ueberauth.Strategy.Helpers
  plug Ueberauth

  def new(conn, _params) do
    render(conn, "new.html", callback_url: Helpers.callback_url(conn))
  end

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    conn
    |> authenticated(Accounts.authenticate_user(auth))
  end

  defp authenticated(conn, {:ok, user}) do
    conn
    |> put_flash(:info, "Successfully authenticated.")
    # |> Plug.put_session(:current_user, user)
    |> redirect(to: "/")
  end

  defp authenticated(conn, {:error, reason}) do
    conn
    |> put_flash(:error, reason)
    |> redirect(to: "/sessions/new")
  end
end
