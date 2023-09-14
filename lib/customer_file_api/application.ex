defmodule CustomerFileApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CustomerFileApiWeb.Telemetry,
      # Start the Ecto repository
      CustomerFileApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CustomerFileApi.PubSub},
      # Start Finch
      {Finch, name: CustomerFileApi.Finch},
      # Start the Endpoint (http/https)
      CustomerFileApiWeb.Endpoint,
      #Start Oban
      {Oban, Application.fetch_env!(:customer_file_api, Oban)},
    ]

    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CustomerFileApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CustomerFileApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
