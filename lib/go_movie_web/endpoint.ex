defmodule GoMovieWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :go_movie

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_go_movie_key",
    signing_salt: "1RsyjkHP"
  ]

  socket "/socket", GoMovieWeb.UserSocket,
    websocket: true,
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :go_movie,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :go_movie
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug(
    CORSPlug,
    origin:
    [
      "http://localhost:8100",
      "https://newgomovie-dev.netlify.app",
      "http://192.168.1.107:8100",
      "http://localhost",
      "https://localhost:8100",
      "https://localhost:4200"

    ],
    methods: ["GET", "POST", "PATCH", "DELETE", "PUT"]
  )
  plug GoMovieWeb.Router
end
