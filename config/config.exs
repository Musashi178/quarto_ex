# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quarto,
  ecto_repos: [Quarto.Repo]

# Configures the endpoint
config :quarto, Quarto.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lKeFtcmR+RzJgcsp7RYKegBNcdqU9Dx8jNFerzLCvRWGszYGLeZZKtan18K4k49v",
  render_errors: [view: Quarto.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Quarto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true

# Configure Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    identity: { Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      uid_field: :email,
      nickname_field: :username,
      request_path: "/sessions/new",
      callback_path: "/sessions/identity/callback"
    ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
