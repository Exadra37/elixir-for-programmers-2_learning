defmodule HangmanLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HangmanLiveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HangmanLive.PubSub},
      # Start the Endpoint (http/https)
      HangmanLiveWeb.Endpoint
      # Start a worker by calling: HangmanLive.Worker.start_link(arg)
      # {HangmanLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HangmanLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HangmanLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
