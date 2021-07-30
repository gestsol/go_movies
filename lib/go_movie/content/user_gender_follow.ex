defmodule GoMovie.Content.UserGenderFollow do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "user_genders_follow" do
    field :status, :integer, default: 1

    timestamps()
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id, primary_key: true
    belongs_to :gender, GoMovie.Content.Gender, foreign_key: :gender_id, references: :gender_id, primary_key: true

  end

  @doc false
  def changeset(user_gender_follow, attrs) do
    user_gender_follow
    |> cast(attrs, [:status, :user_id, :gender_id])
    |> unique_constraint([:user_id, :gender_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:gender_id)
    |> validate_required([:user_id, :gender_id])
  end
end
