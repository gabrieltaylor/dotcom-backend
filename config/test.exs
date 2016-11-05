use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dotcom, Dotcom.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :dotcom, Dotcom.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_"),
  password: System.get_env("PG_"),
  database: "dotcom_test",
  hostname: System.get_env("PG_"),
  pool: Ecto.Adapters.SQL.Sandbox
