defmodule ModernArt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ModernArt.Repo,
      # Start the Telemetry supervisor
      ModernArtWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ModernArt.PubSub},
      # Start the Endpoint (http/https)
      ModernArtWeb.Endpoint
      # Start a worker by calling: ModernArt.Worker.start_link(arg)
      # {ModernArt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ModernArt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ModernArtWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
