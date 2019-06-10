defmodule Aasm.MixProject do
  use Mix.Project

  @version "0.1.0"
  @github "https://github.com/zven21/aasm"

  def project do
    [
      app: :aasm,
      version: @version,
      description: "The finite state machine implementations for Elixir.",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      # aliases: aliases(),
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
      {:ex_doc, ">= 0.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
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

  defp elixirc_paths(:test), do: ["lib", "priv", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # defp aliases do
  #   [
  #     test: [
  #       "ecto.drop --quiet",
  #       "ecto.create --quiet",
  #       "ecto.migrate --quiet",
  #       "test"
  #     ]
  #   ]
  # end
end
