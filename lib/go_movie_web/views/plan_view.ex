defmodule GoMovieWeb.PlanView do
  use GoMovieWeb, :view
  alias GoMovieWeb.PlanView

  def render("index.json", %{plans: plans}) do
    %{plans: render_many(plans, PlanView, "plan.json")}
  end

  def render("show.json", %{plan: plan}) do
    %{plan: render_one(plan, PlanView, "plan.json")}
  end

  def render("plan.json", %{plan: plan}) do
    %{
      plan_id: plan.plan_id,
      name: plan.name,
      description: plan.description,
      price: plan.price,
      duration: plan.duration,
      device_quantity: plan.device_quantity,
      status: plan.status
    }
  end
end
