defmodule RclexListener.MixProject do
  use Mix.Project

  def project do
    [
      app: :rclex_listener,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rclex, "~> 0.6.1"}
    ]
  end
end
