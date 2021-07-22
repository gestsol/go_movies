defmodule GoMovieWeb.UserPlanController do
  use GoMovieWeb, :controller

  alias GoMovie.Business
  alias GoMovie.Business.UserPlan

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    user_plans = Business.list_user_plans()
    render(conn, "index.json", user_plans: user_plans)
  end

  def create(conn, %{"user_plan" => user_plan_params}) do
    with {:ok, %UserPlan{} = user_plan} <- Business.create_user_plan(user_plan_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user_plan: user_plan)
    end
  end

  def show(conn, %{"user_id" => user_id, "plan_id" => plan_id}) do
    user_plan = Business.get_user_plan!(user_id,plan_id)
    render(conn, "show.json", user_plan: user_plan)
  end

  def update(conn, %{"user_id" => user_id, "plan_id" => plan_id, "user_plan" => user_plan_params}) do
    user_plan =  Business.get_user_plan!(user_id,plan_id)

    with {:ok, %UserPlan{} = user_plan} <- Business.update_user_plan(user_plan, user_plan_params) do
      render(conn, "show.json", user_plan: user_plan)
    end
  end

  def delete(conn, %{"user_id" => user_id, "plan_id" => plan_id,}) do
    user_plan = Business.get_user_plan!(user_id,plan_id)

    with {:ok, %UserPlan{}} <- Business.delete_user_plan(user_plan) do
      send_resp(conn, :no_content, "")
    end
  end
end
