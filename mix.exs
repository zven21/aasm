defmodule Aasm.MixProject do
  use Mix.Project

  @version "0.2.0"
  @github "https://github.com/zven21/aasm"

  def project do
    [
      app: :aasm,
      version: @version,
      description: "The finite state machine implementations for Elixir.",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0", only: :test},
      {:ex_machina, "~> 2.2", only: :test}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["zven21"],
      licenses: ["MIT"],
      links: %{"GitHub" => @github}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "priv", "test/support", "test/dummy"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: [
        "ecto.drop --quiet",
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "test"
      ]
    ]
  end
end
