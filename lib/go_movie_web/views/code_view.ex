defmodule GoMovieWeb.CodeView do
  use GoMovieWeb, :view
  alias GoMovieWeb.CodeView

  def render("index.json", %{codes: codes}) do
    %{codes: render_many(codes, CodeView, "code.json")}
  end

  def render("show.json", %{code: code}) do
    %{code: render_one(code, CodeView, "code.json")}
  end

  def render("code.json", %{code: code}) do
    %{
      id: code.code_id,
      name: code.name,
      description: code.description,
      quantity: code.quantity,
      amount: code.amount,
      date_end: code.date_end,
      status: code.status,
      plan_id: code.plan_id
    }
  end
end
