defmodule GoMovie.Repo do
  use Ecto.Repo,
    otp_app: :go_movie,
    adapter: Ecto.Adapters.Postgres
end
