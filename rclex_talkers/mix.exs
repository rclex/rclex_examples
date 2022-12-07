defmodule RclexTalkers.MixProject do
  use Mix.Project

  def project do
    [
      app: :rclex_talkers,
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
      # {:rclex, path: "../../rclex", override: false}
      {:rclex, "~> 0.7.2"}
    ]
  end
end
