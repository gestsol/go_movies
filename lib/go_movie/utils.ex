defmodule GoMovie.MongoUtils do

  def parse_document_objectId(doc) do
    id_string = BSON.ObjectId.encode!(doc["_id"])

    doc |> Map.put("_id", id_string)
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

end
