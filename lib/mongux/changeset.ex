defmodule Mongux.Changeset do

  defstruct [:model, :fields, :changeset_fields, :collection]

  def cast(schema, attrs) do
    module_struct = schema.__struct__
    changeset_fields = module_struct.__changeset__
    fields = Enum.map(changeset_fields, fn {key, _value} -> key end)
    collection = module_struct.__schema__(:collection)

    model = attrs
      |> parse_attrs() # Convertir las keys de attrs en atoms
      |> filter_keys(changeset_fields) # Obtener solo las keys del schema
      |> type_validation(changeset_fields)

    %Mongux.Changeset{
      model: model,
      fields: fields,
      changeset_fields: changeset_fields,
      collection: collection
    }
  end

  def parse_attrs(attrs) do
    attrs |> Enum.reduce(%{}, fn {key, value}, acc ->
      cond do
        is_binary(key) -> Map.put(acc, String.to_atom(key), value)
        is_atom(key) -> Map.put(acc, key, value)
        true -> raise ArgumentError, "Invalid key type: #{key}"
      end
    end)
  end

  def filter_keys(attrs, target_keys) do
    target_keys
    |> Enum.reduce(%{}, fn {key, _value}, acc ->
        Map.put(acc, key, attrs[key])
    end)
  end

  def type_validation(attrs, changeset_fields) do
    changeset_fields
    |> Enum.each(fn {key, value} ->
      attr_value = Map.get(attrs, key)
      case value do
        :string ->
          if is_binary(attr_value) == false && is_nil(attr_value) == false do
            raise ArgumentError, "Wrong type for field: #{key}"
          end
        :number ->
          if is_number(attr_value) == false && is_nil(attr_value) == false do
            raise ArgumentError, "Wrong type for field: #{key}"
          end
        :boolean ->
          if is_boolean(attr_value) == false && is_nil(attr_value) == false do
            raise ArgumentError, "Wrong type for field: #{key}"
          end
        {:has_one, schema} ->
          if is_nil(attrs[key]) == false do
            schema.changeset(struct(schema), attrs[key])
          end
        {:has_many, [schema]} ->
          if is_list(attrs[key]) do
            Enum.each(attrs[key], fn record ->
              if is_nil(attrs[key]) == false do
                schema.changeset(struct(schema), record)
              end
            end)
          else
            raise ArgumentError, "Field #{key} must be an array of #{schema}"
          end
      end
    end)

    attrs
  end

  def validate_required(attrs, required) when is_list(required) do
    if Enum.any?(required, fn x -> is_atom(x) == false end) do
      raise ArgumentError, "Required fields must be specified in atoms."
    end

    if Enum.any?(required, fn x -> x not in attrs.fields end) do
      raise ArgumentError, "Fields for required validation do not match with schema."
    end

    Enum.each(required, fn r ->
      if is_nil(Map.get(attrs.model, r)) do
        raise ArgumentError, "Missing field :#{r}"
      end
    end)

    attrs
  end
end
