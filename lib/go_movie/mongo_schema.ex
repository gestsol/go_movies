defmodule Mongux.Schema do

  alias Mongux.Schema.Metadata

  defmacro mongo_schema(collection, [do: block]) do
    schema_helper(collection, block)
  end

  defp schema_helper(collection, block) do
    prelude =
      quote do

        collection = unquote(collection)

        meta = %Metadata{
          collection: collection,
          schema: __MODULE__
        }

        Module.put_attribute(__MODULE__, :struct_fields, {:__meta__, meta})
        Module.register_attribute(__MODULE__, :struct_fields, accumulate: true)
        try do
          import Ecto.Schema
          unquote(block)
        after
          :ok
        end
      end

    postlude =
      quote unquote: false do
        defstruct @struct_fields
        def __schema__(:collection), do: unquote(collection)
      end

    quote do
      unquote(prelude)
      unquote(postlude)
    end
  end


  defmacro field(name, type) do
    quote do
      Mongux.Schema.__field__(__MODULE__, unquote(name), unquote(type))
    end
  end

  def __field__(mod, name, type) do

    type = check_field_type!(mod, name, type)
    Module.put_attribute(mod, :changeset_fields, {name, type})
    put_struct_field(mod, name)
  end

  defp check_field_type!(_mod, name, type) do

    if is_list(type) && length(type) > 1 do
      raise ArgumentError, "invalid or unknown type #{inspect type} for field #{inspect name} no more than one schema is allowed."
    end

    kind =
      cond do
        type == :name -> :base
        type == :string -> :base
        type == :number -> :base
        is_list(type) -> :many_module
        Code.ensure_compiled(type) == {:module, type} -> :module
        true -> nil
      end

    cond do
      kind == :base ->
        type

      kind == :module and function_exported?(type, :__schema__, 1) ->
        type

      kind  == :many_module and function_exported?(List.first(type), :__schema__, 1) ->
        [type]

      kind == :module and function_exported?(type, :__schema__, 1) == false ->
        raise ArgumentError,
          "#{inspect type} is not a valid schema."

      true ->
        raise ArgumentError, "invalid or unknown type #{inspect type} for field #{inspect name}"
    end
  end

  defp put_struct_field(mod, name) do
    # fields = Module.get_attribute(mod, :struct_fields)

    # if List.keyfind(fields, name, 0) do
    #   raise ArgumentError, "field/association #{inspect name} is already set on schema"
    # end

    Module.put_attribute(mod, :struct_fields, name)
  end

  defmacro __using__(_) do
    quote do
      import Ecto.Schema
    end
  end

  defmacro test do

  end

end
