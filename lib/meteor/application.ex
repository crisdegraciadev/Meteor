defmodule Meteor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MeteorWeb.Telemetry,
      Meteor.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:meteor, :ecto_repos), skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:meteor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Meteor.PubSub},
      # Start a worker by calling: Meteor.Worker.start_link(arg)
      # {Meteor.Worker, arg},
      # Start to serve requests, typically the last entry
      MeteorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Meteor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MeteorWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    System.get_env("BURRITO_TARGET") != nil or
      Application.get_env(:meteor, :skip_migrations, false)
  end
end
