defmodule QuantFitness.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      QuantFitnessWeb.Telemetry,
      # Start the Ecto repository
      QuantFitness.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: QuantFitness.PubSub},
      # Start Finch
      {Finch, name: QuantFitness.Finch},
      # Start the Endpoint (http/https)
      QuantFitnessWeb.Endpoint
      # Start a worker by calling: QuantFitness.Worker.start_link(arg)
      # {QuantFitness.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuantFitness.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuantFitnessWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
