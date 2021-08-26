defmodule GoMovie.Content.SeenMovies do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seen_movies" do
    field :movie_id, :string
    # field :user_id, :id

    timestamps()
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id
  end

  @doc false
  def changeset(seen_movies, attrs) do
    seen_movies
    |> cast(attrs, [:movie_id, :user_id])
    |> validate_required([:movie_id, :user_id])
  end
end
