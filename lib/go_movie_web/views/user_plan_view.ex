defmodule GoMovieWeb.UserPlanView do
  use GoMovieWeb, :view
  alias GoMovieWeb.UserPlanView

  def render("index.json", %{user_plans: user_plans}) do
    %{user_plans: render_many(user_plans, UserPlanView, "user_plan.json")}
  end

  def render("show.json", %{user_plan: user_plan}) do
    %{user_plan: render_one(user_plan, UserPlanView, "user_plan.json")}
  end

  def render("user_plan.json", %{user_plan: user_plan}) do
    %{
      date_start: user_plan.date_start,
      date_end: user_plan.date_end,
      status: user_plan.status,
      user_id: user_plan.user_id,
      plan_id: user_plan.plan_id
    }

  end
end
