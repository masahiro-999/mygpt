defmodule Mygpt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MygptWeb.Telemetry,
      # Start the Ecto repository
      Mygpt.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mygpt.PubSub},
      # Start Finch
      {Finch, name: Mygpt.Finch},
      # Start the Endpoint (http/https)
      MygptWeb.Endpoint
      # Start a worker by calling: Mygpt.Worker.start_link(arg)
      # {Mygpt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mygpt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MygptWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
