defmodule GoMovie.ContentTest do
  use GoMovie.DataCase

  alias GoMovie.Content

  describe "resources" do
    alias GoMovie.Content.Resource

    @valid_attrs %{average: "120.5", chapter: 42, description: "some description", duration: 42, name: "some name", poster_url: "some poster_url", season: 42, status: 42, trailer_url: "some trailer_url", url: "some url", year: 42}
    @update_attrs %{average: "456.7", chapter: 43, description: "some updated description", duration: 43, name: "some updated name", poster_url: "some updated poster_url", season: 43, status: 43, trailer_url: "some updated trailer_url", url: "some updated url", year: 43}
    @invalid_attrs %{average: nil, chapter: nil, description: nil, duration: nil, name: nil, poster_url: nil, season: nil, status: nil, trailer_url: nil, url: nil, year: nil}

    def resource_fixture(attrs \\ %{}) do
      {:ok, resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_resource()

      resource
    end

    test "list_resources/0 returns all resources" do
      resource = resource_fixture()
      assert Content.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = resource_fixture()
      assert Content.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      assert {:ok, %Resource{} = resource} = Content.create_resource(@valid_attrs)
      assert resource.average == Decimal.new("120.5")
      assert resource.chapter == 42
      assert resource.description == "some description"
      assert resource.duration == 42
      assert resource.name == "some name"
      assert resource.poster_url == "some poster_url"
      assert resource.season == 42
      assert resource.status == 42
      assert resource.trailer_url == "some trailer_url"
      assert resource.url == "some url"
      assert resource.year == 42
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_resource(@invalid_attrs)
    end

    test "update_resource/2 with valid data updates the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{} = resource} = Content.update_resource(resource, @update_attrs)
      assert resource.average == Decimal.new("456.7")
      assert resource.chapter == 43
      assert resource.description == "some updated description"
      assert resource.duration == 43
      assert resource.name == "some updated name"
      assert resource.poster_url == "some updated poster_url"
      assert resource.season == 43
      assert resource.status == 43
      assert resource.trailer_url == "some updated trailer_url"
      assert resource.url == "some updated url"
      assert resource.year == 43
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_resource(resource, @invalid_attrs)
      assert resource == Content.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Content.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Content.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Content.change_resource(resource)
    end
  end

  describe "resource_types" do
    alias GoMovie.Content.ResourceType

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def resource_type_fixture(attrs \\ %{}) do
      {:ok, resource_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_resource_type()

      resource_type
    end

    test "list_resource_types/0 returns all resource_types" do
      resource_type = resource_type_fixture()
      assert Content.list_resource_types() == [resource_type]
    end

    test "get_resource_type!/1 returns the resource_type with given id" do
      resource_type = resource_type_fixture()
      assert Content.get_resource_type!(resource_type.id) == resource_type
    end

    test "create_resource_type/1 with valid data creates a resource_type" do
      assert {:ok, %ResourceType{} = resource_type} = Content.create_resource_type(@valid_attrs)
      assert resource_type.description == "some description"
      assert resource_type.name == "some name"
      assert resource_type.status == 42
    end

    test "create_resource_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_resource_type(@invalid_attrs)
    end

    test "update_resource_type/2 with valid data updates the resource_type" do
      resource_type = resource_type_fixture()
      assert {:ok, %ResourceType{} = resource_type} = Content.update_resource_type(resource_type, @update_attrs)
      assert resource_type.description == "some updated description"
      assert resource_type.name == "some updated name"
      assert resource_type.status == 43
    end

    test "update_resource_type/2 with invalid data returns error changeset" do
      resource_type = resource_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_resource_type(resource_type, @invalid_attrs)
      assert resource_type == Content.get_resource_type!(resource_type.id)
    end

    test "delete_resource_type/1 deletes the resource_type" do
      resource_type = resource_type_fixture()
      assert {:ok, %ResourceType{}} = Content.delete_resource_type(resource_type)
      assert_raise Ecto.NoResultsError, fn -> Content.get_resource_type!(resource_type.id) end
    end

    test "change_resource_type/1 returns a resource_type changeset" do
      resource_type = resource_type_fixture()
      assert %Ecto.Changeset{} = Content.change_resource_type(resource_type)
    end
  end

  describe "genders" do
    alias GoMovie.Content.Gender

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def gender_fixture(attrs \\ %{}) do
      {:ok, gender} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_gender()

      gender
    end

    test "list_genders/0 returns all genders" do
      gender = gender_fixture()
      assert Content.list_genders() == [gender]
    end

    test "get_gender!/1 returns the gender with given id" do
      gender = gender_fixture()
      assert Content.get_gender!(gender.id) == gender
    end

    test "create_gender/1 with valid data creates a gender" do
      assert {:ok, %Gender{} = gender} = Content.create_gender(@valid_attrs)
      assert gender.description == "some description"
      assert gender.name == "some name"
      assert gender.status == 42
    end

    test "create_gender/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_gender(@invalid_attrs)
    end

    test "update_gender/2 with valid data updates the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{} = gender} = Content.update_gender(gender, @update_attrs)
      assert gender.description == "some updated description"
      assert gender.name == "some updated name"
      assert gender.status == 43
    end

    test "update_gender/2 with invalid data returns error changeset" do
      gender = gender_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_gender(gender, @invalid_attrs)
      assert gender == Content.get_gender!(gender.id)
    end

    test "delete_gender/1 deletes the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{}} = Content.delete_gender(gender)
      assert_raise Ecto.NoResultsError, fn -> Content.get_gender!(gender.id) end
    end

    test "change_gender/1 returns a gender changeset" do
      gender = gender_fixture()
      assert %Ecto.Changeset{} = Content.change_gender(gender)
    end
  end

  describe "resource_genders" do
    alias GoMovie.Content.ResourceGender

    @valid_attrs %{status: 42}
    @update_attrs %{status: 43}
    @invalid_attrs %{status: nil}

    def resource_gender_fixture(attrs \\ %{}) do
      {:ok, resource_gender} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_resource_gender()

      resource_gender
    end

    test "list_resource_genders/0 returns all resource_genders" do
      resource_gender = resource_gender_fixture()
      assert Content.list_resource_genders() == [resource_gender]
    end

    test "get_resource_gender!/1 returns the resource_gender with given id" do
      resource_gender = resource_gender_fixture()
      assert Content.get_resource_gender!(resource_gender.id) == resource_gender
    end

    test "create_resource_gender/1 with valid data creates a resource_gender" do
      assert {:ok, %ResourceGender{} = resource_gender} = Content.create_resource_gender(@valid_attrs)
      assert resource_gender.status == 42
    end

    test "create_resource_gender/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_resource_gender(@invalid_attrs)
    end

    test "update_resource_gender/2 with valid data updates the resource_gender" do
      resource_gender = resource_gender_fixture()
      assert {:ok, %ResourceGender{} = resource_gender} = Content.update_resource_gender(resource_gender, @update_attrs)
      assert resource_gender.status == 43
    end

    test "update_resource_gender/2 with invalid data returns error changeset" do
      resource_gender = resource_gender_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_resource_gender(resource_gender, @invalid_attrs)
      assert resource_gender == Content.get_resource_gender!(resource_gender.id)
    end

    test "delete_resource_gender/1 deletes the resource_gender" do
      resource_gender = resource_gender_fixture()
      assert {:ok, %ResourceGender{}} = Content.delete_resource_gender(resource_gender)
      assert_raise Ecto.NoResultsError, fn -> Content.get_resource_gender!(resource_gender.id) end
    end

    test "change_resource_gender/1 returns a resource_gender changeset" do
      resource_gender = resource_gender_fixture()
      assert %Ecto.Changeset{} = Content.change_resource_gender(resource_gender)
    end
  end

  describe "user_genders_follow" do
    alias GoMovie.Content.UserGenderFollow

    @valid_attrs %{status: 42}
    @update_attrs %{status: 43}
    @invalid_attrs %{status: nil}

    def user_gender_follow_fixture(attrs \\ %{}) do
      {:ok, user_gender_follow} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_user_gender_follow()

      user_gender_follow
    end

    test "list_user_genders_follow/0 returns all user_genders_follow" do
      user_gender_follow = user_gender_follow_fixture()
      assert Content.list_user_genders_follow() == [user_gender_follow]
    end

    test "get_user_gender_follow!/1 returns the user_gender_follow with given id" do
      user_gender_follow = user_gender_follow_fixture()
      assert Content.get_user_gender_follow!(user_gender_follow.id) == user_gender_follow
    end

    test "create_user_gender_follow/1 with valid data creates a user_gender_follow" do
      assert {:ok, %UserGenderFollow{} = user_gender_follow} = Content.create_user_gender_follow(@valid_attrs)
      assert user_gender_follow.status == 42
    end

    test "create_user_gender_follow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_user_gender_follow(@invalid_attrs)
    end

    test "update_user_gender_follow/2 with valid data updates the user_gender_follow" do
      user_gender_follow = user_gender_follow_fixture()
      assert {:ok, %UserGenderFollow{} = user_gender_follow} = Content.update_user_gender_follow(user_gender_follow, @update_attrs)
      assert user_gender_follow.status == 43
    end

    test "update_user_gender_follow/2 with invalid data returns error changeset" do
      user_gender_follow = user_gender_follow_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_user_gender_follow(user_gender_follow, @invalid_attrs)
      assert user_gender_follow == Content.get_user_gender_follow!(user_gender_follow.id)
    end

    test "delete_user_gender_follow/1 deletes the user_gender_follow" do
      user_gender_follow = user_gender_follow_fixture()
      assert {:ok, %UserGenderFollow{}} = Content.delete_user_gender_follow(user_gender_follow)
      assert_raise Ecto.NoResultsError, fn -> Content.get_user_gender_follow!(user_gender_follow.id) end
    end

    test "change_user_gender_follow/1 returns a user_gender_follow changeset" do
      user_gender_follow = user_gender_follow_fixture()
      assert %Ecto.Changeset{} = Content.change_user_gender_follow(user_gender_follow)
    end
  end

  describe "languages" do
    alias GoMovie.Content.Language

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_language()

      language
    end

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Content.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Content.get_language!(language.id) == language
    end

    test "create_language/1 with valid data creates a language" do
      assert {:ok, %Language{} = language} = Content.create_language(@valid_attrs)
      assert language.description == "some description"
      assert language.name == "some name"
      assert language.status == 42
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_language(@invalid_attrs)
    end

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      assert {:ok, %Language{} = language} = Content.update_language(language, @update_attrs)
      assert language.description == "some updated description"
      assert language.name == "some updated name"
      assert language.status == 43
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_language(language, @invalid_attrs)
      assert language == Content.get_language!(language.id)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Content.delete_language(language)
      assert_raise Ecto.NoResultsError, fn -> Content.get_language!(language.id) end
    end

    test "change_language/1 returns a language changeset" do
      language = language_fixture()
      assert %Ecto.Changeset{} = Content.change_language(language)
    end
  end

  describe "user_movies_playbacks" do
    alias GoMovie.Content.UserMoviePlayback

    @valid_attrs %{movie_id: "some movie_id", seekable: "120.5"}
    @update_attrs %{movie_id: "some updated movie_id", seekable: "456.7"}
    @invalid_attrs %{movie_id: nil, seekable: nil}

    def user_movie_playback_fixture(attrs \\ %{}) do
      {:ok, user_movie_playback} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_user_movie_playback()

      user_movie_playback
    end

    test "list_user_movies_playbacks/0 returns all user_movies_playbacks" do
      user_movie_playback = user_movie_playback_fixture()
      assert Content.list_user_movies_playbacks() == [user_movie_playback]
    end

    test "get_user_movie_playback!/1 returns the user_movie_playback with given id" do
      user_movie_playback = user_movie_playback_fixture()
      assert Content.get_user_movie_playback!(user_movie_playback.id) == user_movie_playback
    end

    test "create_user_movie_playback/1 with valid data creates a user_movie_playback" do
      assert {:ok, %UserMoviePlayback{} = user_movie_playback} = Content.create_user_movie_playback(@valid_attrs)
      assert user_movie_playback.movie_id == "some movie_id"
      assert user_movie_playback.seekable == Decimal.new("120.5")
    end

    test "create_user_movie_playback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_user_movie_playback(@invalid_attrs)
    end

    test "update_user_movie_playback/2 with valid data updates the user_movie_playback" do
      user_movie_playback = user_movie_playback_fixture()
      assert {:ok, %UserMoviePlayback{} = user_movie_playback} = Content.update_user_movie_playback(user_movie_playback, @update_attrs)
      assert user_movie_playback.movie_id == "some updated movie_id"
      assert user_movie_playback.seekable == Decimal.new("456.7")
    end

    test "update_user_movie_playback/2 with invalid data returns error changeset" do
      user_movie_playback = user_movie_playback_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_user_movie_playback(user_movie_playback, @invalid_attrs)
      assert user_movie_playback == Content.get_user_movie_playback!(user_movie_playback.id)
    end

    test "delete_user_movie_playback/1 deletes the user_movie_playback" do
      user_movie_playback = user_movie_playback_fixture()
      assert {:ok, %UserMoviePlayback{}} = Content.delete_user_movie_playback(user_movie_playback)
      assert_raise Ecto.NoResultsError, fn -> Content.get_user_movie_playback!(user_movie_playback.id) end
    end

    test "change_user_movie_playback/1 returns a user_movie_playback changeset" do
      user_movie_playback = user_movie_playback_fixture()
      assert %Ecto.Changeset{} = Content.change_user_movie_playback(user_movie_playback)
    end
  end

  describe "seen_movies" do
    alias GoMovie.Content.SeenMovies

    @valid_attrs %{movie_id: "some movie_id"}
    @update_attrs %{movie_id: "some updated movie_id"}
    @invalid_attrs %{movie_id: nil}

    def seen_movies_fixture(attrs \\ %{}) do
      {:ok, seen_movies} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_seen_movies()

      seen_movies
    end

    test "list_seen_movies/0 returns all seen_movies" do
      seen_movies = seen_movies_fixture()
      assert Content.list_seen_movies() == [seen_movies]
    end

    test "get_seen_movies!/1 returns the seen_movies with given id" do
      seen_movies = seen_movies_fixture()
      assert Content.get_seen_movies!(seen_movies.id) == seen_movies
    end

    test "create_seen_movies/1 with valid data creates a seen_movies" do
      assert {:ok, %SeenMovies{} = seen_movies} = Content.create_seen_movies(@valid_attrs)
      assert seen_movies.movie_id == "some movie_id"
    end

    test "create_seen_movies/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_seen_movies(@invalid_attrs)
    end

    test "update_seen_movies/2 with valid data updates the seen_movies" do
      seen_movies = seen_movies_fixture()
      assert {:ok, %SeenMovies{} = seen_movies} = Content.update_seen_movies(seen_movies, @update_attrs)
      assert seen_movies.movie_id == "some updated movie_id"
    end

    test "update_seen_movies/2 with invalid data returns error changeset" do
      seen_movies = seen_movies_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_seen_movies(seen_movies, @invalid_attrs)
      assert seen_movies == Content.get_seen_movies!(seen_movies.id)
    end

    test "delete_seen_movies/1 deletes the seen_movies" do
      seen_movies = seen_movies_fixture()
      assert {:ok, %SeenMovies{}} = Content.delete_seen_movies(seen_movies)
      assert_raise Ecto.NoResultsError, fn -> Content.get_seen_movies!(seen_movies.id) end
    end

    test "change_seen_movies/1 returns a seen_movies changeset" do
      seen_movies = seen_movies_fixture()
      assert %Ecto.Changeset{} = Content.change_seen_movies(seen_movies)
    end
  end

  describe "series_playbacks" do
    alias GoMovie.Content.SeriePlayback

    @valid_attrs %{chapter_id: "some chapter_id", season_id: "some season_id", seekable: "120.5", serie_id: "some serie_id"}
    @update_attrs %{chapter_id: "some updated chapter_id", season_id: "some updated season_id", seekable: "456.7", serie_id: "some updated serie_id"}
    @invalid_attrs %{chapter_id: nil, season_id: nil, seekable: nil, serie_id: nil}

    def serie_playback_fixture(attrs \\ %{}) do
      {:ok, serie_playback} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_serie_playback()

      serie_playback
    end

    test "list_series_playbacks/0 returns all series_playbacks" do
      serie_playback = serie_playback_fixture()
      assert Content.list_series_playbacks() == [serie_playback]
    end

    test "get_serie_playback!/1 returns the serie_playback with given id" do
      serie_playback = serie_playback_fixture()
      assert Content.get_serie_playback!(serie_playback.id) == serie_playback
    end

    test "create_serie_playback/1 with valid data creates a serie_playback" do
      assert {:ok, %SeriePlayback{} = serie_playback} = Content.create_serie_playback(@valid_attrs)
      assert serie_playback.chapter_id == "some chapter_id"
      assert serie_playback.season_id == "some season_id"
      assert serie_playback.seekable == Decimal.new("120.5")
      assert serie_playback.serie_id == "some serie_id"
    end

    test "create_serie_playback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_serie_playback(@invalid_attrs)
    end

    test "update_serie_playback/2 with valid data updates the serie_playback" do
      serie_playback = serie_playback_fixture()
      assert {:ok, %SeriePlayback{} = serie_playback} = Content.update_serie_playback(serie_playback, @update_attrs)
      assert serie_playback.chapter_id == "some updated chapter_id"
      assert serie_playback.season_id == "some updated season_id"
      assert serie_playback.seekable == Decimal.new("456.7")
      assert serie_playback.serie_id == "some updated serie_id"
    end

    test "update_serie_playback/2 with invalid data returns error changeset" do
      serie_playback = serie_playback_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_serie_playback(serie_playback, @invalid_attrs)
      assert serie_playback == Content.get_serie_playback!(serie_playback.id)
    end

    test "delete_serie_playback/1 deletes the serie_playback" do
      serie_playback = serie_playback_fixture()
      assert {:ok, %SeriePlayback{}} = Content.delete_serie_playback(serie_playback)
      assert_raise Ecto.NoResultsError, fn -> Content.get_serie_playback!(serie_playback.id) end
    end

    test "change_serie_playback/1 returns a serie_playback changeset" do
      serie_playback = serie_playback_fixture()
      assert %Ecto.Changeset{} = Content.change_serie_playback(serie_playback)
    end
  end
end
