defmodule GoMovie.Content.Gender do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :gender_id}
	@primary_key {:gender_id, :id, autogenerate: true}

  schema "genders" do
    field :description, :string
    field :name, :string
    field :status, :integer, default: 1

    timestamps()
  end

  @doc false
  def changeset(gender, attrs) do
    gender
    |> cast(attrs, [:name, :description, :status, :gender_id])
    |> validate_required([:name, :description, :status])
  end
end
