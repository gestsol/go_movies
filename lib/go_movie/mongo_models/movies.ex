defmodule GoMovie.MongoModel.Movie do
  alias GoMovie.MongoUtils, as: Util
  alias GoMovie.AWSUtils
  alias GoMovie.Content.UserMoviePlayback, as: Playback

  @collection_name "resources_movies"
  @movie_images ["poster_url", "thumb", "landscape_poster_url"]

  def get_movies_by_ids(movies_ids, fields \\ []) when is_list(movies_ids) do
    or_values = movies_ids |> Enum.map(&Util.build_query_by_id/1)

    projection = Util.build_projection(fields)

    Mongo.find(:mongo, @collection_name, %{"$or" => or_values}, projection: projection)
    |> Enum.map(&Util.parse_document_objectId/1)
  end

  def get_movies(search \\ "", fields \\ []) do
    search = if is_nil(search), do: "", else: search

    regex_for_name_and_artists = %{
      "$regex": Util.diacritic_sensitive_regex(search),
      "$options": "gi"
    }

    filter = %{
      "$or" => [
        %{name: regex_for_name_and_artists},
        %{"artists.name": regex_for_name_and_artists}
      ]
    }

    projection = Util.build_projection(fields)

    Mongo.find(:mongo, @collection_name, filter, projection: projection)
    |> Enum.map(&Util.parse_document_objectId/1)
  end

  def append_movie_to_playback(playback, movies) when is_list(movies) do
    movie = Enum.find(movies, &(&1["_id"] == playback.movie_id))

    unless is_nil(movie) do
      Map.merge(
        %{
          "id" => playback.id,
          "seekable" => playback.seekable,
          "movie_duration" => playback.duration,
          "movie_id" => playback.movie_id,
          "user_id" => playback.user_id,
          "progress" => Playback.calc_progress(playback)
        },
        movie
      )
    else
      nil
    end
  end

  def map_playbacks_with_movies(playbacks, movies_fields) do
    # If movies_fields is empty, just select movie ids
    movies_fields = if Enum.empty?(movies_fields), do: ["_id"], else: movies_fields

    unless Enum.empty?(playbacks) do
      movies =
        playbacks
        |> Enum.map(& &1.movie_id)
        |> get_movies_by_ids(movies_fields)

      Enum.map(playbacks, &append_movie_to_playback(&1, movies))
      |> Enum.reject(&is_nil/1)
    else
      []
    end
  end

  def delete_movie_images(id, images) do
    movie = Util.get_by_id(id, @collection_name)
    AWSUtils.delete_multiple_images_from_S3(movie, "covers", images)
  end

  def delete_movie(id) do
    delete_movie_images(id, @movie_images)
    Util.delete(id, @collection_name)
  end

  def update_movie(params, id) do

    images_to_delete = Enum.reduce(@movie_images, [], fn acc, img ->
      if Map.has_key?(params, img) do
        [img | acc]
      else
        acc
      end
    end)

    if length(images_to_delete) > 0 do
      delete_movie_images(id, images_to_delete)
    end

    Util.update(params, @collection_name, id)
  end
end
