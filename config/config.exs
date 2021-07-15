# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :go_movie,
  ecto_repos: [GoMovie.Repo]

# Configures the endpoint
config :go_movie, GoMovieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RXt/iswrjM2hUmEOyMEgq+ug+jZJKqtKVo1WinZf0jNwz+qhbXyjJK4/Zubv0CRk",
  render_errors: [view: GoMovieWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GoMovie.PubSub,
  live_view: [signing_salt: "157lmE6x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
