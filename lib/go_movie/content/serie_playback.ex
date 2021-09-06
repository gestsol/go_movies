defmodule GoMovie.Content.SeriePlayback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "series_playbacks" do
    field :chapter_id, :string # ESTO ES EL ID DE MONGO
    field :season_id, :string # ESTO ES EL ID DE MONGO
    field :seekable, :decimal
    field :serie_id, :string # ESTO ES EL ID DE MONGO
    field :duration, :decimal # chapter duration in seconds

    timestamps()
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id
  end

  @doc false
  def changeset(serie_playback, attrs) do
    serie_playback
    |> cast(attrs, [:serie_id, :season_id, :chapter_id, :seekable, :user_id, :duration])
    |> validate_required([:serie_id, :season_id, :chapter_id, :seekable, :user_id])
  end
end
