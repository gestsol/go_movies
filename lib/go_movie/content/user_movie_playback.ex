defmodule GoMovie.Content.UserMoviePlayback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_movies_playbacks" do
    field :movie_id, :string # ID DE MONGO
    field :seekable, :decimal
    field :duration, :decimal # Movie duration in seconds

    timestamps()
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id
  end

  @doc false
  def changeset(user_movie_playback, attrs) do
    user_movie_playback
    |> cast(attrs, [:seekable, :movie_id, :user_id, :duration])
    |> validate_required([:seekable, :movie_id, :user_id, :duration])
  end

  def calc_progress(%{seekable: seekable, duration: duration}) do
    if seekable && duration && duration > 0 do
      Decimal.mult(seekable, 100)
      |> Decimal.div(duration)
      |> Decimal.round(2)
    else
      0
    end
  end

  def append_progress_to_playback(playback) do
    progress = calc_progress(playback)
    Map.put(playback, :progress, progress)
  end
end
