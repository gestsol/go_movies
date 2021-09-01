defmodule GoMovie.MongoModel.Movie do
  alias GoMovie.MongoUtils, as: Util

  @collection_name "resources_movies"

  def get_movies_by_ids(movies_ids, fields \\ []) when is_list(movies_ids) do
    or_values = movies_ids |> Enum.map(&Util.build_query_by_id/1)

    projection = Util.build_projection(fields)

    Mongo.find(:mongo, @collection_name, %{"$or" => or_values}, projection: projection)
    |> Enum.map(&Util.parse_document_objectId/1)
  end

  def get_movies(search \\ "", fields \\ []) do
    search = if is_nil(search), do: "", else: search

    regex_for_name_and_artists =  %{
      "$regex": Util.diacritic_sensitive_regex(search),
      "$options": "gi"
    }

    filter = %{
      "$or" => [
        %{ name: regex_for_name_and_artists },
        %{ "artists.name": regex_for_name_and_artists }
      ]
    }

    projection = Util.build_projection(fields)

    Mongo.find(:mongo, @collection_name, filter, projection: projection)
    |> Enum.map(&Util.parse_document_objectId/1)
  end
end
