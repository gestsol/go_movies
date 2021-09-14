defmodule GoMovie.MongoModel.Serie do
  alias GoMovie.MongoUtils, as: Util
  alias GoMovie.AWSUtils

  @collection_name "resources_series"
  @chapter_images ["poster_url", "thumb", "landscape_poster_url"]
  @serie_images ["poster_url", "thumb", "landscape_poster_url"]

  def get_series(search \\ "", fields \\ []) when is_list(fields) do
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
    |> Enum.map(fn serie ->
      serie = Util.parse_document_objectId(serie)
      if serie["seasons"], do: parse_seasons_and_chapters_ids(serie), else: serie
    end)
  end

  def update_serie(params, id) do
    delete_images_on_serie_update(params, id)
    Util.update(params, @collection_name, id)
  end

  def delete_images_on_serie_update(params, serie_id) do
    images_to_delete = Enum.reduce(@serie_images, [], fn acc, img ->
      if Map.has_key?(params, img) do
        [img | acc]
      else
        acc
      end
    end)

    if length(images_to_delete) > 0 do
      delete_serie_images(serie_id, false)
    end
  end

  def handle_season_update(params, serie_id, season_id) do
    bson_serie_id = BSON.ObjectId.decode!(serie_id)
    bson_season_id = BSON.ObjectId.decode!(season_id)

    selector = %{
      "$and" => [
        %{_id: bson_serie_id},
        %{"seasons._id": bson_season_id}
      ]
    }

    fields_to_update =
      Enum.reduce(params, %{}, fn {k, value}, acc ->
        field = "seasons.$[season].#{k}"
        Map.put(acc, field, value)
      end)

    set = %{"$set": fields_to_update}

    opts = [
      array_filters: [
        %{"season._id": bson_season_id}
      ]
    ]

    {:ok, result} = Mongo.update_one(:mongo, @collection_name, selector, set, opts)

    cond do
      result.matched_count == 1 && result.modified_count == 1 ->
        find_season(season_id)

      result.matched_count == 1 && result.modified_count == 0 ->
        find_season(season_id)

      result.matched_count == 0 && result.modified_count == 0 ->
        {:error, "Invalid serie_id or season_id"}
    end
  end

  def update_season(params, serie_id, season_id) do
    if params["chapters"] do
      {:error, "Is not allowed to update seasons chapters."}
    else
      handle_season_update(params, serie_id, season_id)
    end
  end

  @doc """
  Update a series chapter.
  @params: map containing the fields to update
  """
  def update_series_chapter(params, serie_id, season_id, chapter_id) do
    bson_chapter_id = BSON.ObjectId.decode!(chapter_id)
    bson_serie_id = BSON.ObjectId.decode!(serie_id)
    bson_season_id = BSON.ObjectId.decode!(season_id)

    selector = %{
      "$and" => [
        %{_id: bson_serie_id},
        %{"seasons._id": bson_season_id},
        %{"seasons.chapters._id": bson_chapter_id}
      ]
    }

    fields_to_update =
      Enum.reduce(params, %{}, fn {k, value}, acc ->
        field = "seasons.$[season].chapters.$[chapter].#{k}"
        Map.put(acc, field, value)
      end)

    set = %{"$set": fields_to_update}

    opts = [
      array_filters: [
        %{"season._id": bson_season_id},
        %{"chapter._id": bson_chapter_id}
      ]
    ]

    {:ok, result} = Mongo.update_one(:mongo, @collection_name, selector, set, opts)

    cond do
      result.matched_count == 1 && result.modified_count == 1 ->
        delete_images_on_chapter_update(params, chapter_id)
        find_chapter(chapter_id)

      result.matched_count == 1 && result.modified_count == 0 ->
        delete_images_on_chapter_update(params, chapter_id)
        find_chapter(chapter_id)

      result.matched_count == 0 && result.modified_count == 0 ->
        {:error, "Invalid serie_id or season_id or chapter_id"}
    end
  end

  def delete_images_on_chapter_update(params, chapter_id) do
    images_to_delete = Enum.reduce(@chapter_images, [], fn acc, img ->
      if Map.has_key?(params, img) do
        [img | acc]
      else
        acc
      end
    end)

    if length(images_to_delete) > 0 do
      delete_chapter_images(chapter_id)
    end
  end

  def delete_chapter(serie_id, season_id, chapter_id) do
    bson_chapter_id = BSON.ObjectId.decode!(chapter_id)
    bson_serie_id = BSON.ObjectId.decode!(serie_id)
    bson_season_id = BSON.ObjectId.decode!(season_id)

    selector = %{
      "$and" => [
        %{_id: bson_serie_id},
        %{"seasons._id": bson_season_id},
        %{"seasons.chapters._id": bson_chapter_id}
      ]
    }

    update = %{
      "$pull": %{
        "seasons.$.chapters": %{_id: bson_chapter_id}
      }
    }

    {:ok, result} = Mongo.update_one(:mongo, @collection_name, selector, update)

    cond do
      result.matched_count == 1 && result.modified_count == 1 ->
        delete_chapter_images(chapter_id)
        {:ok, "Chapter successfully deleted."}

      result.matched_count == 1 && result.modified_count == 0 ->
        delete_chapter_images(chapter_id)
        {:ok, "Chapter successfully deleted."}

      result.matched_count == 0 && result.modified_count == 0 ->
        {:error, "Invalid serie_id or season_id or chapter_id"}
    end
  end

  def delete_chapters(serie_id, season_id) do
    bson_serie_id = BSON.ObjectId.decode!(serie_id)
    bson_season_id = BSON.ObjectId.decode!(season_id)

    selector = %{
      "$and" => [
        %{_id: bson_serie_id},
        %{"seasons._id": bson_season_id}
      ]
    }

    update = %{
      "$pull": %{
        "seasons.$.chapters": %{}
      }
    }

    {:ok, result} = Mongo.update_one(:mongo, @collection_name, selector, update)

    cond do
      result.matched_count == 1 && result.modified_count == 1 ->
        {:ok, "Chapter successfully deleted."}

      result.matched_count == 1 && result.modified_count == 0 ->
        {:ok, "Chapter successfully deleted."}

      result.matched_count == 0 && result.modified_count == 0 ->
        {:error, "Invalid serie_id or season_id or chapter_id"}
    end
  end

  def delete_season(serie_id, season_id) do
    bson_serie_id = BSON.ObjectId.decode!(serie_id)
    bson_season_id = BSON.ObjectId.decode!(season_id)

    selector = %{
      "$and" => [
        %{_id: bson_serie_id},
        %{"seasons._id": bson_season_id}
      ]
    }

    update = %{
      "$pull": %{
        seasons: %{_id: bson_season_id}
      }
    }

    {:ok, season} = find_season(season_id)

    {:ok, result} = Mongo.update_one(:mongo, @collection_name, selector, update)

    cond do
      result.matched_count == 1 && result.modified_count == 1 ->
        delete_season_images(season)
        {:ok, "Season successfully deleted."}

      result.matched_count == 1 && result.modified_count == 0 ->
        delete_season_images(season)
        {:ok, "Season successfully deleted."}

      result.matched_count == 0 && result.modified_count == 0 ->
        {:error, "Invalid serie_id or season_id"}
    end
  end

  def add_season(params, serie_id) do
    serie_id = BSON.ObjectId.decode!(serie_id)
    params = Util.append_id(params)

    params =
      unless Map.has_key?(params, "chapters") do
        Map.put(params, "chapters", [])
      else
        params
      end

    filter = %{_id: serie_id}

    update = %{
      "$push": %{
        "seasons" => params
      }
    }

    {:ok, status} = Mongo.update_one(:mongo, @collection_name, filter, update)

    if status.matched_count == 1 && status.modified_count == 1 do
      params["_id"]
      |> BSON.ObjectId.encode!()
      |> find_season()
    else
      {:error, "Invalid serie_id"}
    end
  end

  def add_chapter(params, serie_id, season_id) do
    serie_id = BSON.ObjectId.decode!(serie_id)
    season_id = BSON.ObjectId.decode!(season_id)
    params = Util.append_id(params)
    chapter_id = BSON.ObjectId.encode!(params["_id"])

    filter = %{_id: serie_id, "seasons._id": season_id}

    update = %{
      "$push": %{
        "seasons.$.chapters" => params
      }
    }

    {:ok, result} = Mongo.update_one(:mongo, @collection_name, filter, update)

    cond do
      result.matched_count == 1 && result.modified_count == 1 ->
        find_chapter(chapter_id)

      result.matched_count == 1 && result.modified_count == 0 ->
        find_chapter(chapter_id)

      result.matched_count == 0 && result.modified_count == 0 ->
        {:error, "Invalid serie_id or season_id"}
    end
  end

  def find_chapter(chapter_id) do
    bson_chapter_id = BSON.ObjectId.decode!(chapter_id)

    filter = %{
      "seasons.chapters._id": bson_chapter_id
    }

    projection = %{
      _id: 0,
      "seasons.chapters.$": 1
    }

    result = Mongo.find_one(:mongo, @collection_name, filter, projection: projection)

    unless is_nil(result) do
      chapter =
        Map.get(result, "seasons")
        |> List.first()
        |> Map.get("chapters")
        |> Enum.find(fn c -> c["_id"] == chapter_id end)
        |> Util.parse_document_objectId()

      {:ok, chapter}
    else
      {:error, "Unable to find chapter with id: #{chapter_id}"}
    end
  end

  def get_first_chapter(serie_id) do
    serie_id = BSON.ObjectId.decode!(serie_id)

    pipeline = [
      %{
        "$match": %{ _id: serie_id }
      },
      %{
        "$project": %{
          chapter: %{
            "$map": %{
              input: "$seasons",
              as: "season",
              in: %{
                chapter: %{
                  "$slice": ["$$season.chapters", 1]
                },
                season_id: "$$season._id"
              }
            }
          },
          _id: 1
        }
      }
    ]

    result = Mongo.aggregate(:mongo, @collection_name, pipeline) |> Enum.to_list() |> List.first()
    serie_id = Map.get(result, "_id") |> BSON.ObjectId.encode!()
    season_id = Map.get(result, "chapter") |> List.first() |> Map.get("season_id") |> BSON.ObjectId.encode!()

    chapter = Map.get(result, "chapter")
      |> List.first()
      |> Map.get("chapter")
      |> List.first()
      |> Map.put("serie_id", serie_id)
      |> Map.put("season_id", season_id)
      |> Util.parse_document_objectId()

    Map.put(chapter, "chapter_id", chapter["_id"])
  end

  def find_season(season_id) do
    bson_season_id = BSON.ObjectId.decode!(season_id)

    filter = %{
      "seasons._id": bson_season_id
    }

    projection = %{
      _id: 0,
      "seasons.$": 1
    }

    result = Mongo.find_one(:mongo, @collection_name, filter, projection: projection)

    unless is_nil(result) do
      season =
        result
        |> Map.get("seasons")
        |> List.first()
        |> parse_one_season_and_chapters_ids()

      {:ok, season}
    else
      {:error, "Unable to find season with id: #{season_id}"}
    end
  end

  def get_series_by_ids(ids, fields \\ []) when is_list(ids) and is_list(fields) do
    or_values = ids |> Enum.map(&Util.build_query_by_id/1)

    projection = Util.build_projection(fields)

    Mongo.find(:mongo, @collection_name, %{"$or" => or_values}, projection: projection)
    |> Enum.map(&Util.parse_document_objectId/1)
  end

  @doc """
  Add mongodb ID for each season and chapter
  """
  def append_id_to_seasons_and_chapters(serie) do
    Map.get(serie, "seasons")
    |> Enum.map(fn s ->
      new_season = Util.append_id(s)
      chapters = Map.get(new_season, "chapters")
      new_chapters = Enum.map(chapters, &Util.append_id/1)
      Map.put(new_season, "chapters", new_chapters)
    end)
  end

  def handle_serie_insertion(serie) do
    serie = Map.delete(serie, "_id")

    if Map.has_key?(serie, "seasons") do
      seasons = append_id_to_seasons_and_chapters(serie)
      Map.put(serie, "seasons", seasons)
    else
      Map.put(serie, "seasons", [])
    end
  end

  def parse_seasons_and_chapters_ids(serie) do
    seasons =
      Map.get(serie, "seasons")
      |> Enum.map(fn s ->
        new_season = Util.parse_document_objectId(s)
        chapters = Map.get(new_season, "chapters")
        new_chapters = Enum.map(chapters, &Util.parse_document_objectId/1)
        Map.put(new_season, "chapters", new_chapters)
      end)

    Map.put(serie, "seasons", seasons)
  end

  def parse_one_season_and_chapters_ids(season) do
    season = Util.parse_document_objectId(season)

    chapters =
      season
      |> Map.get("chapters")
      |> Enum.map(&Util.parse_document_objectId/1)

    Map.put(season, "chapters", chapters)
  end

  def delete_serie(id) do
    delete_serie_images(id, true)
    Util.delete(id, @collection_name)
  end

  def delete_serie_images(id, delete_chapter_images) when is_boolean(delete_chapter_images) do
    serie = Util.get_by_id(id, @collection_name)

    AWSUtils.delete_multiple_images_from_S3(serie, "covers",  ["poster_url", "thumb", "landscape_poster_url"])

    if delete_chapter_images == true do
      delete_chapter_images_from_serie(serie)
    end
  end

  def delete_chapter_images_from_serie(serie) do
    seasons = Map.get(serie, "seasons")

    if seasons do
      Enum.each(seasons, &delete_season_images/1)
    end
  end

  def delete_season_images(season) do
    chapters = Map.get(season, "chapters")
    if chapters do
      Enum.each(chapters, &delete_chapter_images/1)
    end
  end

  def delete_chapter_images(chapter) when is_map(chapter) do
    AWSUtils.delete_multiple_images_from_S3(chapter, "covers",  ["poster_url", "thumb", "landscape_poster_url"])
  end

  def delete_chapter_images(id) when is_binary(id) do
    with {:ok, chapter} <- find_chapter(id)  do
      delete_chapter_images(chapter)
    end
  end
end
