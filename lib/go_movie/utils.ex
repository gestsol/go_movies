defmodule GoMovie.MongoUtils do

  def parse_document_objectId(doc, field \\ "_id") do
    id_string = BSON.ObjectId.encode!(doc[field])

    doc |> Map.put(field, id_string)
  end

  def append_id(doc) do
    id = Mongo.IdServer.new()
    Map.put(doc, "_id", id)
  end

  def find_all(collection_name) do
    Mongo.find(:mongo, collection_name, %{})
    |> Enum.map(&parse_document_objectId/1)
  end

  def get_by_id(id, collection_name) do
    id_bson = BSON.ObjectId.decode!(id)

    Mongo.find_one(:mongo, collection_name, %{_id: id_bson})
    |> parse_document_objectId()
  end

  def find_in(collection_name, field, targets) when is_list(targets) and is_atom(field) do
    query = Map.put(%{}, field, %{"$in" => targets})

    Mongo.find(:mongo, collection_name, query)
    |> Enum.map(&parse_document_objectId/1)
  end

  def insert_one(params, collection_name) do
    {:ok, resource} = Mongo.insert_one(:mongo, collection_name, params)

    id = resource.inserted_id

    Mongo.find_one(:mongo, collection_name, %{_id: id})
    |> parse_document_objectId()
  end

  def update(params, collection_name, id) do
    id_bson = BSON.ObjectId.decode!(id)

    {:ok, resource} = Mongo.find_one_and_update(:mongo, collection_name, %{_id: id_bson}, %{"$set": params})

    Mongo.find_one(:mongo, collection_name, %{_id: resource["_id"]})
    |> parse_document_objectId()
  end

  def delete(id, collection_name) do
    id_bson = BSON.ObjectId.decode!(id)
    Mongo.delete_one(:mongo, collection_name, %{_id: id_bson})
  end

  def validate_genders(genders) do
    error =
      cond do
        is_nil(genders) ->
          "Missing field genders."

        is_list(genders) == false ->
          "Field genders must be of type array."

        length(genders) == 0 ->
          "Field genders is empty."

        is_nil(Enum.find(genders, fn g -> is_binary(g) == false end)) == false ->
          "Field genders must be an array of strings"

        true ->
          nil
      end

    if is_nil(error) do
      valid_genders = find_in("genders", :name, genders)
      genders_names = valid_genders |> Enum.map(fn g -> g["name"] end)
      invalid_gender = Enum.find(genders, fn g -> g not in genders_names end)

      case is_nil(invalid_gender) do
        true -> {:ok, valid_genders}
        false -> {:error, "Invalid gender: #{invalid_gender}"}
      end
    else
      {:error, error}
    end
  end

end
