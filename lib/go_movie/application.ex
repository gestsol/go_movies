defmodule GoMovie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GoMovie.Repo,
      {Mongo, [name: :mongo, url: System.get_env("MONGO_DB_URL_CONNECTION")]},
      # Start the Telemetry supervisor
      GoMovieWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GoMovie.PubSub},
      # Start the ets tables
      {GoMovie.Cache.Sliders, []},
      # Start the Endpoint (http/https)
      GoMovieWeb.Endpoint,
      # Start a worker by calling: GoMovie.Worker.start_link(arg)
      # {GoMovie.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoMovie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GoMovieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
