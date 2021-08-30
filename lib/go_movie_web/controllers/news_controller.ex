defmodule GoMovieWeb.NewsController do
  use GoMovieWeb, :controller

  alias GoMovie.News

  def index(conn, _params) do
    news = News.get_news()

    json(conn, %{news: news})
  end

end
