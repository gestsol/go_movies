defmodule GoMovieWeb.SeenMoviesControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.SeenMovies

  @create_attrs %{
    movie_id: "some movie_id"
  }
  @update_attrs %{
    movie_id: "some updated movie_id"
  }
  @invalid_attrs %{movie_id: nil}

  def fixture(:seen_movies) do
    {:ok, seen_movies} = Content.create_seen_movies(@create_attrs)
    seen_movies
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all seen_movies", %{conn: conn} do
      conn = get(conn, Routes.seen_movies_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create seen_movies" do
    test "renders seen_movies when data is valid", %{conn: conn} do
      conn = post(conn, Routes.seen_movies_path(conn, :create), seen_movies: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.seen_movies_path(conn, :show, id))

      assert %{
               "id" => id,
               "movie_id" => "some movie_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.seen_movies_path(conn, :create), seen_movies: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update seen_movies" do
    setup [:create_seen_movies]

    test "renders seen_movies when data is valid", %{conn: conn, seen_movies: %SeenMovies{id: id} = seen_movies} do
      conn = put(conn, Routes.seen_movies_path(conn, :update, seen_movies), seen_movies: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.seen_movies_path(conn, :show, id))

      assert %{
               "id" => id,
               "movie_id" => "some updated movie_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, seen_movies: seen_movies} do
      conn = put(conn, Routes.seen_movies_path(conn, :update, seen_movies), seen_movies: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete seen_movies" do
    setup [:create_seen_movies]

    test "deletes chosen seen_movies", %{conn: conn, seen_movies: seen_movies} do
      conn = delete(conn, Routes.seen_movies_path(conn, :delete, seen_movies))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.seen_movies_path(conn, :show, seen_movies))
      end
    end
  end

  defp create_seen_movies(_) do
    seen_movies = fixture(:seen_movies)
    %{seen_movies: seen_movies}
  end
end
