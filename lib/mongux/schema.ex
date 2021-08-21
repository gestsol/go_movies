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

        Module.register_attribute(__MODULE__, :struct_fields, accumulate: true)
        Module.register_attribute(__MODULE__, :changeset_fields, accumulate: true)
        Module.put_attribute(__MODULE__, :struct_fields, {:__meta__, meta})

        try do
          import Mongux.Schema
          unquote(block)
        after
          :ok
        end
      end

    postlude =
      quote unquote: false do
        defstruct @struct_fields
        def __schema__(:collection), do: unquote(collection)
        def __changeset__ do
          %{unquote_splicing(Macro.escape(@changeset_fields))}
        end
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
        type == :string -> :base
        type == :number -> :base
        type == :boolean -> :base
        is_list(type) && Code.ensure_compiled(List.first(type)) == {:module, List.first(type)} -> :many_module
        Code.ensure_compiled(type) == {:module, type} -> :module
        true -> nil
      end

    cond do
      kind == :base ->
        type

      kind == :module and function_exported?(type, :__schema__, 1) ->
        {:has_one, type}

      kind  == :many_module and function_exported?(List.first(type), :__schema__, 1) ->
        {:has_many, type}

      kind == :module and function_exported?(type, :__schema__, 1) == false ->
        raise ArgumentError,
          "#{inspect type} is not a valid schema."

      true ->
        raise ArgumentError, "invalid or unknown type #{inspect type} for field #{inspect name}"
    end
  end

  defp put_struct_field(mod, name) do
    Module.put_attribute(mod, :struct_fields, name)
  end

  defmacro __using__(_) do
    quote do
      import Mongux.Schema
    end
  end

end
