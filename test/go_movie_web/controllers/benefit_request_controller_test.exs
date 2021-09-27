defmodule GoMovieWeb.BenefitRequestControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Account
  alias GoMovie.Account.BenefitRequest

  @create_attrs %{
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    phone_number: "some phone_number",
    rut: "some rut"
  }
  @update_attrs %{
    email: "some updated email",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    phone_number: "some updated phone_number",
    rut: "some updated rut"
  }
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, phone_number: nil, rut: nil}

  def fixture(:benefit_request) do
    {:ok, benefit_request} = Account.create_benefit_request(@create_attrs)
    benefit_request
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all benefit_requests", %{conn: conn} do
      conn = get(conn, Routes.benefit_request_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create benefit_request" do
    test "renders benefit_request when data is valid", %{conn: conn} do
      conn = post(conn, Routes.benefit_request_path(conn, :create), benefit_request: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.benefit_request_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "phone_number" => "some phone_number",
               "rut" => "some rut"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.benefit_request_path(conn, :create), benefit_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update benefit_request" do
    setup [:create_benefit_request]

    test "renders benefit_request when data is valid", %{conn: conn, benefit_request: %BenefitRequest{id: id} = benefit_request} do
      conn = put(conn, Routes.benefit_request_path(conn, :update, benefit_request), benefit_request: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.benefit_request_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "phone_number" => "some updated phone_number",
               "rut" => "some updated rut"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, benefit_request: benefit_request} do
      conn = put(conn, Routes.benefit_request_path(conn, :update, benefit_request), benefit_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete benefit_request" do
    setup [:create_benefit_request]

    test "deletes chosen benefit_request", %{conn: conn, benefit_request: benefit_request} do
      conn = delete(conn, Routes.benefit_request_path(conn, :delete, benefit_request))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.benefit_request_path(conn, :show, benefit_request))
      end
    end
  end

  defp create_benefit_request(_) do
    benefit_request = fixture(:benefit_request)
    %{benefit_request: benefit_request}
  end
end
