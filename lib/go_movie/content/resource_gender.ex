defmodule GoMovie.Content.ResourceGender do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "resource_genders" do
    field :status, :integer, default: 1

    timestamps()
    belongs_to :resource, GoMovie.Content.Resource, foreign_key: :resource_id, references: :resource_id, primary_key: true
    belongs_to :gender, GoMovie.Content.Gender, foreign_key: :gender_id, references: :gender_id, primary_key: true
  end

  @doc false
  def changeset(resource_gender, attrs) do
    resource_gender
    |> cast(attrs, [:status, :resource_id, :gender_id])
    |> unique_constraint([:resource_id, :gender_id])
    |> foreign_key_constraint(:resource_id)
    |> foreign_key_constraint(:gender_id)
    |> validate_required([:status, :resource_id, :gender_id])
  end
end
