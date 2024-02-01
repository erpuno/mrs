defmodule MRS.Mixfile do
  use Mix.Project

  def project do
    [
      app: :mrs,
      version: "0.12.0",
      elixir: ">= 1.9.0",
      description: "MRS Medication Registry System (dec.gov.ua)",
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [ mod: { MRS.Application, [] },
      extra_applications: [ :jsone, :logger, :inets, :ssl, :crypto ]
    ]
  end

  def package do
    [
      files: ~w(lib mix.exs),
      licenses: ["ISC"],
      maintainers: ["Namdak Tonpa"],
      name: :mrs,
      links: %{"GitHub" => "https://github.com/erpuno/mrs"}
    ]
  end

  def deps do
    [
      {:ex_doc, "~> 0.21", only: :dev},
      {:jsone, "~> 1.5.1"}
    ]
  end
end
