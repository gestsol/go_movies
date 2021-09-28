defmodule GoMovieWeb.UserSessionView do
  use GoMovieWeb, :view
  alias GoMovieWeb.UserSessionView

  def render("index.json", %{user_sessions: user_sessions}) do
    %{data: render_many(user_sessions, UserSessionView, "user_session.json")}
  end

  def render("show.json", %{user_session: user_session}) do
    %{data: render_one(user_session, UserSessionView, "user_session.json")}
  end

  def render("user_session.json", %{user_session: user_session}) do
    %{id: user_session.id,
      user_id: user_session.user_id,
      token: user_session.token,
      browser: user_session.browser,
      device: user_session.device
    }
  end
end
