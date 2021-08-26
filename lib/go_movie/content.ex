defmodule GoMovie.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias GoMovie.Repo

  alias GoMovie.Content.Resource

  @doc """
  Returns the list of resources.

  ## Examples

      iex> list_resources()
      [%Resource{}, ...]

  """
  def list_resources do
    Repo.all(Resource)
    |> Repo.preload([:resource_type])
    |> Repo.preload([resource_genders: :gender])
  end

  @doc """
  Gets a single resource.

  Raises `Ecto.NoResultsError` if the Resource does not exist.

  ## Examples

      iex> get_resource!(123)
      %Resource{}

      iex> get_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource!(id) do
    Repo.get!(Resource, id)
    |> Repo.preload([:resource_type])
    |> Repo.preload([resource_genders: :gender])
  end

  @doc """
  Creates a resource.

  ## Examples

      iex> create_resource(%{field: value})
      {:ok, %Resource{}}

      iex> create_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource(attrs \\ %{}) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a resource.

  ## Examples

      iex> update_resource(resource, %{field: new_value})
      {:ok, %Resource{}}

      iex> update_resource(resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a resource.

  ## Examples

      iex> delete_resource(resource)
      {:ok, %Resource{}}

      iex> delete_resource(resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource(%Resource{} = resource) do
    Repo.delete(resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource changes.

  ## Examples

      iex> change_resource(resource)
      %Ecto.Changeset{data: %Resource{}}

  """
  def change_resource(%Resource{} = resource, attrs \\ %{}) do
    Resource.changeset(resource, attrs)
  end

  alias GoMovie.Content.ResourceType

  @doc """
  Returns the list of resource_types.

  ## Examples

      iex> list_resource_types()
      [%ResourceType{}, ...]

  """
  def list_resource_types do
    Repo.all(ResourceType)
  end

  @doc """
  Gets a single resource_type.

  Raises `Ecto.NoResultsError` if the Resource type does not exist.

  ## Examples

      iex> get_resource_type!(123)
      %ResourceType{}

      iex> get_resource_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource_type!(id), do: Repo.get!(ResourceType, id)

  @doc """
  Creates a resource_type.

  ## Examples

      iex> create_resource_type(%{field: value})
      {:ok, %ResourceType{}}

      iex> create_resource_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource_type(attrs \\ %{}) do
    %ResourceType{}
    |> ResourceType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a resource_type.

  ## Examples

      iex> update_resource_type(resource_type, %{field: new_value})
      {:ok, %ResourceType{}}

      iex> update_resource_type(resource_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource_type(%ResourceType{} = resource_type, attrs) do
    resource_type
    |> ResourceType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a resource_type.

  ## Examples

      iex> delete_resource_type(resource_type)
      {:ok, %ResourceType{}}

      iex> delete_resource_type(resource_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource_type(%ResourceType{} = resource_type) do
    Repo.delete(resource_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource_type changes.

  ## Examples

      iex> change_resource_type(resource_type)
      %Ecto.Changeset{data: %ResourceType{}}

  """
  def change_resource_type(%ResourceType{} = resource_type, attrs \\ %{}) do
    ResourceType.changeset(resource_type, attrs)
  end

  alias GoMovie.Content.Gender

  @doc """
  Returns the list of genders.

  ## Examples

      iex> list_genders()
      [%Gender{}, ...]

  """
  def list_genders do
    Repo.all(Gender)
  end

  @doc """
  Gets a single gender.

  Raises `Ecto.NoResultsError` if the Gender does not exist.

  ## Examples

      iex> get_gender!(123)
      %Gender{}

      iex> get_gender!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gender!(id), do: Repo.get!(Gender, id)

  @doc """
  Creates a gender.

  ## Examples

      iex> create_gender(%{field: value})
      {:ok, %Gender{}}

      iex> create_gender(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gender(attrs \\ %{}) do
    %Gender{}
    |> Gender.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gender.

  ## Examples

      iex> update_gender(gender, %{field: new_value})
      {:ok, %Gender{}}

      iex> update_gender(gender, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gender(%Gender{} = gender, attrs) do
    gender
    |> Gender.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gender.

  ## Examples

      iex> delete_gender(gender)
      {:ok, %Gender{}}

      iex> delete_gender(gender)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gender(%Gender{} = gender) do
    Repo.delete(gender)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gender changes.

  ## Examples

      iex> change_gender(gender)
      %Ecto.Changeset{data: %Gender{}}

  """
  def change_gender(%Gender{} = gender, attrs \\ %{}) do
    Gender.changeset(gender, attrs)
  end

  alias GoMovie.Content.ResourceGender

  @doc """
  Returns the list of resource_genders.

  ## Examples

      iex> list_resource_genders()
      [%ResourceGender{}, ...]

  """
  def list_resource_genders do
    Repo.all(ResourceGender)
  end

  @doc """
  Gets a single resource_gender.

  Raises `Ecto.NoResultsError` if the Resource gender does not exist.

  ## Examples

      iex> get_resource_gender!(123)
      %ResourceGender{}

      iex> get_resource_gender!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource_gender!(resource_id, gender_id), do: Repo.get_by!(ResourceGender, resource_id: resource_id, gender_id: gender_id)

  @doc """
  Creates a resource_gender.

  ## Examples

      iex> create_resource_gender(%{field: value})
      {:ok, %ResourceGender{}}

      iex> create_resource_gender(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource_gender(attrs \\ %{}) do
    %ResourceGender{}
    |> ResourceGender.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a resource_gender.

  ## Examples

      iex> update_resource_gender(resource_gender, %{field: new_value})
      {:ok, %ResourceGender{}}

      iex> update_resource_gender(resource_gender, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource_gender(%ResourceGender{} = resource_gender, attrs) do
    resource_gender
    |> ResourceGender.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a resource_gender.

  ## Examples

      iex> delete_resource_gender(resource_gender)
      {:ok, %ResourceGender{}}

      iex> delete_resource_gender(resource_gender)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource_gender(%ResourceGender{} = resource_gender) do
    Repo.delete(resource_gender)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource_gender changes.

  ## Examples

      iex> change_resource_gender(resource_gender)
      %Ecto.Changeset{data: %ResourceGender{}}

  """
  def change_resource_gender(%ResourceGender{} = resource_gender, attrs \\ %{}) do
    ResourceGender.changeset(resource_gender, attrs)
  end

  alias GoMovie.Content.UserGenderFollow

  @doc """
  Returns the list of user_genders_follow.

  ## Examples

      iex> list_user_genders_follow()
      [%UserGenderFollow{}, ...]

  """
  def list_user_genders_follow do
    Repo.all(UserGenderFollow)
  end

  @doc """
  Gets a single user_gender_follow.

  Raises `Ecto.NoResultsError` if the User gender follow does not exist.

  ## Examples

      iex> get_user_gender_follow!(123)
      %UserGenderFollow{}

      iex> get_user_gender_follow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_gender_follow!(user_id, gender_id), do: Repo.get_by!(UserGenderFollow, user_id: user_id, gender_id: gender_id)

  @doc """
  Creates a user_gender_follow.

  ## Examples

      iex> create_user_gender_follow(%{field: value})
      {:ok, %UserGenderFollow{}}

      iex> create_user_gender_follow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_gender_follow(attrs \\ %{}) do
    %UserGenderFollow{}
    |> UserGenderFollow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_gender_follow.

  ## Examples

      iex> update_user_gender_follow(user_gender_follow, %{field: new_value})
      {:ok, %UserGenderFollow{}}

      iex> update_user_gender_follow(user_gender_follow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_gender_follow(%UserGenderFollow{} = user_gender_follow, attrs) do
    user_gender_follow
    |> UserGenderFollow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_gender_follow.

  ## Examples

      iex> delete_user_gender_follow(user_gender_follow)
      {:ok, %UserGenderFollow{}}

      iex> delete_user_gender_follow(user_gender_follow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_gender_follow(%UserGenderFollow{} = user_gender_follow) do
    Repo.delete(user_gender_follow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_gender_follow changes.

  ## Examples

      iex> change_user_gender_follow(user_gender_follow)
      %Ecto.Changeset{data: %UserGenderFollow{}}

  """
  def change_user_gender_follow(%UserGenderFollow{} = user_gender_follow, attrs \\ %{}) do
    UserGenderFollow.changeset(user_gender_follow, attrs)
  end

  alias GoMovie.Content.Language

  @doc """
  Returns the list of languages.

  ## Examples

      iex> list_languages()
      [%Language{}, ...]

  """
  def list_languages do
    Repo.all(Language)
  end

  @doc """
  Gets a single language.

  Raises `Ecto.NoResultsError` if the Language does not exist.

  ## Examples

      iex> get_language!(123)
      %Language{}

      iex> get_language!(456)
      ** (Ecto.NoResultsError)

  """
  def get_language!(id), do: Repo.get!(Language, id)

  @doc """
  Creates a language.

  ## Examples

      iex> create_language(%{field: value})
      {:ok, %Language{}}

      iex> create_language(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a language.

  ## Examples

      iex> update_language(language, %{field: new_value})
      {:ok, %Language{}}

      iex> update_language(language, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_language(%Language{} = language, attrs) do
    language
    |> Language.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a language.

  ## Examples

      iex> delete_language(language)
      {:ok, %Language{}}

      iex> delete_language(language)
      {:error, %Ecto.Changeset{}}

  """
  def delete_language(%Language{} = language) do
    Repo.delete(language)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking language changes.

  ## Examples

      iex> change_language(language)
      %Ecto.Changeset{data: %Language{}}

  """
  def change_language(%Language{} = language, attrs \\ %{}) do
    Language.changeset(language, attrs)
  end

  alias GoMovie.Content.UserMoviePlayback

  @doc """
  Returns the list of user_movies_playbacks.

  ## Examples

      iex> list_user_movies_playbacks()
      [%UserMoviePlayback{}, ...]

  """
  def list_user_movies_playbacks do
    Repo.all(UserMoviePlayback)
  end

  def list_user_movies_playbacks(query) do
    Repo.all(query)
  end

  @doc """
  Gets a single user_movie_playback.

  Raises `Ecto.NoResultsError` if the User movie playback does not exist.

  ## Examples

      iex> get_user_movie_playback!(123)
      %UserMoviePlayback{}

      iex> get_user_movie_playback!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_movie_playback!(id), do: Repo.get!(UserMoviePlayback, id)

  def get_movie_playback_by_user_and_movie(user_id, movie_id) do
    UserMoviePlayback
    |> where(user_id: ^user_id)
    |> where(movie_id: ^movie_id)
    |> Repo.one()
  end

  @doc """
  Creates a user_movie_playback.

  ## Examples

      iex> create_user_movie_playback(%{field: value})
      {:ok, %UserMoviePlayback{}}

      iex> create_user_movie_playback(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_movie_playback(attrs \\ %{}) do
    %UserMoviePlayback{}
    |> UserMoviePlayback.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_movie_playback.

  ## Examples

      iex> update_user_movie_playback(user_movie_playback, %{field: new_value})
      {:ok, %UserMoviePlayback{}}

      iex> update_user_movie_playback(user_movie_playback, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_movie_playback(%UserMoviePlayback{} = user_movie_playback, attrs) do
    user_movie_playback
    |> UserMoviePlayback.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_movie_playback.

  ## Examples

      iex> delete_user_movie_playback(user_movie_playback)
      {:ok, %UserMoviePlayback{}}

      iex> delete_user_movie_playback(user_movie_playback)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_movie_playback(%UserMoviePlayback{} = user_movie_playback) do
    Repo.delete(user_movie_playback)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_movie_playback changes.

  ## Examples

      iex> change_user_movie_playback(user_movie_playback)
      %Ecto.Changeset{data: %UserMoviePlayback{}}

  """
  def change_user_movie_playback(%UserMoviePlayback{} = user_movie_playback, attrs \\ %{}) do
    UserMoviePlayback.changeset(user_movie_playback, attrs)
  end

  alias GoMovie.Content.SeenMovies

  @doc """
  Returns the list of seen_movies.

  ## Examples

      iex> list_seen_movies()
      [%SeenMovies{}, ...]

  """
  def list_seen_movies do
    Repo.all(SeenMovies)
  end

  def list_seen_movies(query) do
    Repo.all(query)
  end

  @doc """
  Gets a single seen_movies.

  Raises `Ecto.NoResultsError` if the Seen movies does not exist.

  ## Examples

      iex> get_seen_movies!(123)
      %SeenMovies{}

      iex> get_seen_movies!(456)
      ** (Ecto.NoResultsError)

  """
  def get_seen_movies!(id), do: Repo.get!(SeenMovies, id)

  @doc """
  Creates a seen_movies.

  ## Examples

      iex> create_seen_movies(%{field: value})
      {:ok, %SeenMovies{}}

      iex> create_seen_movies(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_seen_movies(attrs \\ %{}) do
    %SeenMovies{}
    |> SeenMovies.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a seen_movies.

  ## Examples

      iex> update_seen_movies(seen_movies, %{field: new_value})
      {:ok, %SeenMovies{}}

      iex> update_seen_movies(seen_movies, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_seen_movies(%SeenMovies{} = seen_movies, attrs) do
    seen_movies
    |> SeenMovies.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a seen_movies.

  ## Examples

      iex> delete_seen_movies(seen_movies)
      {:ok, %SeenMovies{}}

      iex> delete_seen_movies(seen_movies)
      {:error, %Ecto.Changeset{}}

  """
  def delete_seen_movies(%SeenMovies{} = seen_movies) do
    Repo.delete(seen_movies)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking seen_movies changes.

  ## Examples

      iex> change_seen_movies(seen_movies)
      %Ecto.Changeset{data: %SeenMovies{}}

  """
  def change_seen_movies(%SeenMovies{} = seen_movies, attrs \\ %{}) do
    SeenMovies.changeset(seen_movies, attrs)
  end
end
