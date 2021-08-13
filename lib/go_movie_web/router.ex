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
    post "/users/sign_in_google", UserController, :sign_in_google
    post "/users/sign_in_facebook", UserController, :sign_in_facebook
  end

  scope "/api", GoMovieWeb do
    #pipe_through :api
    pipe_through [:api, :api_auth]
    resources "/roles", RoleController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit, :create]
    resources "/plans", PlanController, except: [:new, :edit]
    resources "/codes", CodeController, except: [:new, :edit]
    resources "/user_plans", UserPlanController, only: [:index, :create]
    get "/user_plans/:user_id/:plan_id", UserPlanController, :show
    patch "/user_plans/:user_id/:plan_id", UserPlanController, :update
    delete "/user_plans/:user_id/:plan_id", UserPlanController, :delete
    resources "/purchases", PurchaseController, except: [:new, :edit]
    resources "/resources", ResourceController, except: [:new, :edit]
    resources "/resource_types", ResourceTypeController, except: [:new, :edit]
    resources "/genders", GenderController, except: [:new, :edit]

    resources "/resource_genders", ResourceGenderController, only: [:index, :create]
    get "/resource_genders/:resource_id/:gender_id", ResourceGenderController, :show
    patch "/resource_genders/:resource_id/:gender_id", ResourceGenderController, :update
    delete "/resource_genders/:resource_id/:gender_id", ResourceGenderController, :delete

    resources "/user_genders_follow", UserGenderFollowController, only: [:index, :create]
    get "/user_genders_follow/:user_id/:gender_id", UserGenderFollowController, :show
    patch "/user_genders_follow/:user_id/:gender_id", UserGenderFollowController, :update
    delete "/user_genders_follow/:user_id/:gender_id", UserGenderFollowController, :delete

    resources "/languages", LanguageController, except: [:new, :edit]

    resources "/m_resources_movies", ResourceMovieController, except: [:new, :edit]
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
