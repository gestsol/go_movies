defmodule Mongux.Country do
  use Mongux.Schema

  import Mongux.Changeset

  mongo_schema "country" do
    field :name, :string
  end

  def changeset(prueba, attrs) do
    prueba
    |> cast(attrs)
    |> validate_required([:name])
  end

end
