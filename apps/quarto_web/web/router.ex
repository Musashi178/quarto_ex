defmodule QuartoWeb.Router do
  use QuartoWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug QuartoWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", QuartoWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  scope "/api", QuartoWeb do
    pipe_through :api

  end
end
