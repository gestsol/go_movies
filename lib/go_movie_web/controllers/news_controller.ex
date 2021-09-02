defmodule GoMovieWeb.NewsController do
  use GoMovieWeb, :controller

  alias GoMovie.News

  def index(conn, _params) do
    case News.get_news() do
      {:ok, news} -> json(conn, %{news: news})
      {:error, msg} -> put_status(conn, 500) |> json(%{error: msg})
    end
  end

end
