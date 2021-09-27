defmodule GoMovieWeb.BenefitRequestView do
  use GoMovieWeb, :view
  alias GoMovieWeb.BenefitRequestView

  def render("index.json", %{benefit_requests: benefit_requests}) do
    %{data: render_many(benefit_requests, BenefitRequestView, "benefit_request.json")}
  end

  def render("show.json", %{benefit_request: benefit_request}) do
    %{data: render_one(benefit_request, BenefitRequestView, "benefit_request.json")}
  end

  def render("benefit_request.json", %{benefit_request: benefit_request}) do
    %{id: benefit_request.id,
      first_name: benefit_request.first_name,
      last_name: benefit_request.last_name,
      rut: benefit_request.rut,
      email: benefit_request.email,
      phone_number: benefit_request.phone_number}
  end
end
