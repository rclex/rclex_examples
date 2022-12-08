defmodule RclexTopic.MixProject do
  use Mix.Project

  def project do
    [
      app: :rclex_topic,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
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
      # {:rclex, path: "../../rclex", override: false}
      {:rclex, "~> 0.8.2"}
    ]
  end
end
