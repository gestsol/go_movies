defmodule GoMovie.MongoModel.Movie do
  alias GoMovie.MongoUtils, as: Util

  @collection_name "resources_movies"

  def get_movies_by_ids(movies_ids, fields \\ []) when is_list(movies_ids) do
    or_values = movies_ids |> Enum.map(&Util.build_query_by_id/1)

    projection = Util.build_projection(fields)

    Mongo.find(:mongo, @collection_name, %{"$or" => or_values}, projection: projection)
    |> Enum.map(&Util.parse_document_objectId/1)
  end

  def get_movies(search \\ "") do
    search = if is_nil(search), do: "", else: search
    regex = %BSON.Regex{pattern: search, options: "gi"}
    filter = %{
      "$or" => [
        %{ name: regex },
        %{ "artists.name": regex }
      ]
    }

    Mongo.find(:mongo, @collection_name, filter)
    |> Enum.map(&Util.parse_document_objectId/1)
  end
end
