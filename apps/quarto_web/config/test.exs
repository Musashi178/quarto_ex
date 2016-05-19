use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quarto_web, QuartoWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :quarto_web, QuartoWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "quarto_web_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# limit rounds to not slow down test cases
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
