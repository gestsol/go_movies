defmodule GoMovieWeb.LanguageView do
  use GoMovieWeb, :view
  alias GoMovieWeb.LanguageView

  def render("index.json", %{languages: languages}) do
    %{languages: render_many(languages, LanguageView, "language.json")}
  end

  def render("show.json", %{language: language}) do
    %{language: render_one(language, LanguageView, "language.json")}
  end

  def render("language.json", %{language: language}) do
    %{
      language_id: language.language_id,
      name: language.name,
      description: language.description,
      status: language.status
    }
  end
end
