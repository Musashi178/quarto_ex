defmodule Quarto.Web.Router do
  use Quarto.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Quarto.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController

    get "/sessions/new", SessionsController, :new
    post "/sessions/identity/callback", SessionsController, :identity_callback
  end


  # Other scopes may use custom stacks.
  # scope "/api", Quarto.Web do
  #   pipe_through :api
  # end
end
