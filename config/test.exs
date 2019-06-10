use Mix.Config

config :aasm, Dummy.Repo,
  username: "postgres",
  password: "postgres",
  database: "assm_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
