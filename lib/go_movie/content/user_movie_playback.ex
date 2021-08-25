defmodule GoMovie.Content.UserMoviePlayback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_movies_playbacks" do
    field :movie_id, :string
    field :seekable, :decimal
    # field :user_id, :id

    timestamps()
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id
  end

  @doc false
  def changeset(user_movie_playback, attrs) do
    user_movie_playback
    |> cast(attrs, [:seekable, :movie_id, :user_id])
    |> validate_required([:seekable, :movie_id, :user_id])
  end
end
