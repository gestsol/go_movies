defmodule GoMovieWeb.PlanController do
  use GoMovieWeb, :controller

  import GoMovie.Auth, only: [restrict_to_admin: 2]

  alias GoMovie.Business
  alias GoMovie.Business.Plan

  plug :restrict_to_admin when action in [:create, :update, :delete]

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    plans = Business.list_plans()
    render(conn, "index.json", plans: plans)
  end

  def create(conn, %{"plan" => plan_params}) do
    with {:ok, %Plan{} = plan} <- Business.create_plan(plan_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.plan_path(conn, :show, plan))
      |> render("show.json", plan: plan)
    end
  end

  def show(conn, %{"id" => id}) do
    plan = Business.get_plan!(id)
    render(conn, "show.json", plan: plan)
  end

  def update(conn, %{"id" => id, "plan" => plan_params}) do
    plan = Business.get_plan!(id)

    with {:ok, %Plan{} = plan} <- Business.update_plan(plan, plan_params) do
      render(conn, "show.json", plan: plan)
    end
  end

  def delete(conn, %{"id" => id}) do
    plan = Business.get_plan!(id)

    with {:ok, %Plan{}} <- Business.delete_plan(plan) do
      send_resp(conn, :no_content, "")
    end
  end
end
