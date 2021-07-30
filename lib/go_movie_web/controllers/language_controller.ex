defmodule GoMovieWeb.LanguageController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.Language

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    languages = Content.list_languages()
    render(conn, "index.json", languages: languages)
  end

  def create(conn, %{"language" => language_params}) do
    with {:ok, %Language{} = language} <- Content.create_language(language_params) do
      conn
      |> put_status(:created)
      |> render("show.json", language: language)
    end
  end

  def show(conn, %{"id" => id}) do
    language = Content.get_language!(id)
    render(conn, "show.json", language: language)
  end

  def update(conn, %{"id" => id, "language" => language_params}) do
    language = Content.get_language!(id)

    with {:ok, %Language{} = language} <- Content.update_language(language, language_params) do
      render(conn, "show.json", language: language)
    end
  end

  def delete(conn, %{"id" => id}) do
    language = Content.get_language!(id)

    with {:ok, %Language{}} <- Content.delete_language(language) do
      send_resp(conn, :no_content, "")
    end
  end
end
