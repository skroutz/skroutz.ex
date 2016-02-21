defmodule Skroutz.Mixfile do
  use Mix.Project

  def project do
    [app: :skroutz,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package,
     source_url: "https://github.com/skroutz/skroutz.ex",
     description: description]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:httpoison, "~> 0.8"},
     {:poison, "~> 2.0"},

     # Development dependencies
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev},

     # Test dependencies
     {:exvcr, "~> 0.7", only: :test}]
  end

  defp description, do: "Elixir library for accessing the Skroutz API"

  defp package do
    [
      files: ["lib", "mix.exs", "*.md"],
      maintainers: ["Dimitris Zorbas"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/skroutz/skroutz.ex"}
    ]
  end
end
