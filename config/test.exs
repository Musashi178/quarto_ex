use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quarto, Quarto.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :quarto, Quarto.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "quarto_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :guardian, Guardian,
    secret_key: "DPUr#m(P/Jf}W0h9Kz;eei1@y/)Q)zpC%gn4SD=PrZZ9DbB:7!"
