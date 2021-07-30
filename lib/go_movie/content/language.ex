defmodule GoMovie.Content.Language do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :language_id}
	@primary_key {:language_id, :id, autogenerate: true}

  schema "languages" do
    field :description, :string
    field :name, :string
    field :status, :integer, default: 1

    timestamps()
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name, :description, :status, :language_id])
    |> validate_required([:name, :status])
  end
end
