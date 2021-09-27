defmodule GoMovieWeb.BenefitRequestController do
  use GoMovieWeb, :controller

  alias GoMovie.Account
  alias GoMovie.Account.BenefitRequest

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    benefit_requests = Account.list_benefit_requests()
    render(conn, "index.json", benefit_requests: benefit_requests)
  end

  def create(conn, %{"benefit_request" => benefit_request_params}) do
    with {:ok, %BenefitRequest{} = benefit_request} <- Account.create_benefit_request(benefit_request_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.benefit_request_path(conn, :show, benefit_request))
      |> render("show.json", benefit_request: benefit_request)
    end
  end

  def show(conn, %{"id" => id}) do
    benefit_request = Account.get_benefit_request!(id)
    render(conn, "show.json", benefit_request: benefit_request)
  end

  def update(conn, %{"id" => id, "benefit_request" => benefit_request_params}) do
    benefit_request = Account.get_benefit_request!(id)

    with {:ok, %BenefitRequest{} = benefit_request} <- Account.update_benefit_request(benefit_request, benefit_request_params) do
      render(conn, "show.json", benefit_request: benefit_request)
    end
  end

  def delete(conn, %{"id" => id}) do
    benefit_request = Account.get_benefit_request!(id)

    with {:ok, %BenefitRequest{}} <- Account.delete_benefit_request(benefit_request) do
      send_resp(conn, :no_content, "")
    end
  end
end
