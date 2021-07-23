defmodule GoMovieWeb.PurchaseController do
  use GoMovieWeb, :controller

  alias GoMovie.Business
  alias GoMovie.Business.Purchase

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    purchases = Business.list_purchases()
    render(conn, "index.json", purchases: purchases)
  end

  def create(conn, %{"purchase" => purchase_params}) do
    with {:ok, %Purchase{} = purchase} <- Business.create_purchase(purchase_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.purchase_path(conn, :show, purchase))
      |> render("show.json", purchase: purchase)
    end
  end

  def show(conn, %{"id" => id}) do
    purchase = Business.get_purchase!(id)
    render(conn, "show.json", purchase: purchase)
  end

  def update(conn, %{"id" => id, "purchase" => purchase_params}) do
    purchase = Business.get_purchase!(id)

    with {:ok, %Purchase{} = purchase} <- Business.update_purchase(purchase, purchase_params) do
      render(conn, "show.json", purchase: purchase)
    end
  end

  def delete(conn, %{"id" => id}) do
    purchase = Business.get_purchase!(id)

    with {:ok, %Purchase{}} <- Business.delete_purchase(purchase) do
      send_resp(conn, :no_content, "")
    end
  end
end
