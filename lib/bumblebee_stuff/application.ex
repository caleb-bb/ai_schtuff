defmodule BumblebeeStuff.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BumblebeeStuffWeb.Telemetry,
      BumblebeeStuff.Repo,
      {DNSCluster, query: Application.get_env(:bumblebee_stuff, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BumblebeeStuff.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BumblebeeStuff.Finch},
      # Start a worker by calling: BumblebeeStuff.Worker.start_link(arg)
      # {BumblebeeStuff.Worker, arg},
      # Start to serve requests, typically the last entry
      BumblebeeStuffWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BumblebeeStuff.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BumblebeeStuffWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
