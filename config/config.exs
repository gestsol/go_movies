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

config :go_movie, GoMovie.Auth.Guardian,
  # guardian_secret = mix guardian.gen.secret
  issuer: "go_movie",
  secret_key: System.get_env("GUARDIAN_SECRET")

config :tesla, adapter: Tesla.Adapter.Hackney, recv_timeout: 30_000

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  s3: [
    scheme: "https://",
    host: System.get_env("AWS_S3_HOST"),
    region: "us-east-1"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
