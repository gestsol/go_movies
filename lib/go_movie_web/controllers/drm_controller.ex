defmodule GoMovieWeb.DRMController do
  use GoMovieWeb, :controller

  action_fallback GoMovieWeb.FallbackController

  def deliver_license(conn, _params) do
    json(conn, %{
      "profile" => %{
        "purchase" => %{}
      }
    })
  end
end
