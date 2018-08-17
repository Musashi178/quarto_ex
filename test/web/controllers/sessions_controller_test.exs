defmodule Quarto.Web.SessionsControllerTest do
  use Quarto.Web.ConnCase

  alias Quarto.Accounts

  @create_attrs %{email: "some email", password: "password", username: "some username", }

  def fixture(:user) do

      {:ok, user} = Accounts.create_user(@create_attrs)
      user
  end

  def create_auth(email, password_hash) do
    %Ueberauth.Auth {
      provider: :identity,
      uid: email,
      credentials: %{
          other: %{
            password: password_hash
          }
        }
    }
  end

  test "GET /sessions/new", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200)
  end

  test "POST /sessions/identity/callback with not existing user", %{conn: conn} do
    auth = create_auth("some email", "some password")

    conn =
      conn
      |> assign(:ueberauth_auth, auth)
      |> post("/sessions/identity/callback")
    assert html_response(conn, 302)
  end

  test "POST /sessions/identity/callback with existing user and invalid password data", %{conn: conn} do
    auth = create_auth("some email", "some password")

    conn =
      conn
      |> assign(:ueberauth_auth, auth)
      |> post("/sessions/identity/callback")
    assert html_response(conn, 302)
  end

  test "POST /sessions/identity/callback with existing user and valid password data", %{conn: conn} do
    auth = create_auth("some email", "some password")

    conn =
      conn
      |> assign(:ueberauth_auth, auth)
      |> post("/sessions/identity/callback")
    assert html_response(conn, 200)
  end
end
