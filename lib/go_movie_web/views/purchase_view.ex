defmodule GoMovieWeb.PurchaseView do
  use GoMovieWeb, :view
  alias GoMovieWeb.PurchaseView

  def render("index.json", %{purchases: purchases}) do
    %{purchases: render_many(purchases, PurchaseView, "purchase.json")}
  end

  def render("show.json", %{purchase: purchase}) do
    %{purchase: render_one(purchase, PurchaseView, "purchase.json")}
  end

  def render("purchase.json", %{purchase: purchase}) do
    %{
      purchase_id: purchase.purchase_id,
      date: purchase.date,
      amount: purchase.amount,
      description: purchase.description,
      status: purchase.status,
      user_id: purchase.user_id,
      plan_id: purchase.plan_id
    }
  end
end
