defmodule MeatBar.Mixfile do
  use Mix.Project

  def project do
    [app: :meat_bar,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :sqlitex, :sqlite_ecto, :ecto, :csv, :maru],
     mod: {MeatBar, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:maru, "~> 0.10.5"},
     {:csv, "~> 1.4.4"},
     {:sqlite_ecto, "~> 1.1.0"},
     {:distillery, "~> 0.10.1"}]
  end
end
