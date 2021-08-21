defmodule Test do
  require Mongux.Schema

  Mongux.Schema.mongo_schema "prueba" do
    Mongux.Schema.field :name, :string
  end

  def test do
    Module.get_attribute(__MODULE__, :struct_fields)
  end

end
