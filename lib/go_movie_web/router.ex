defmodule GoMovieWeb.Router do
  use GoMovieWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug GoMovie.Auth.Pipeline
  end

  pipeline :api_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", GoMovieWeb do
    pipe_through :api

    post "/users/sign_in", UserController, :sign_in
    post "/users/sign_up", UserController, :create

  end

  scope "/api", GoMovieWeb do
    #pipe_through :api
    pipe_through [:api, :api_auth]
    resources "/roles", RoleController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit, :create]
    resources "/plans", PlanController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GoMovieWeb.Telemetry
    end
  end
end
