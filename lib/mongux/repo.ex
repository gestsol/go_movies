defmodule Mongux.Repo do

  alias Mongux.Changeset

  def insert_one(%Changeset{} = c) do
    {:ok, resource} = Mongo.insert_one(:mongo, c.collection, c.model)

    id = resource.inserted_id

    Mongo.find_one(:mongo, c.collection, %{_id: id})
    |> parse_document_objectId()
  end

  def parse_document_objectId(doc) do
    id_string = BSON.ObjectId.encode!(doc["_id"])

    doc |> Map.put("_id", id_string)
  end

end
