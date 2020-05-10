defmodule GardienOsUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GardienOsUiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GardienOsUi.PubSub},
      # Start the Endpoint (http/https)
      GardienOsUiWeb.Endpoint
      # Start a worker by calling: GardienOsUi.Worker.start_link(arg)
      # {GardienOsUi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GardienOsUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GardienOsUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
