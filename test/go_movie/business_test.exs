defmodule GoMovie.BusinessTest do
  use GoMovie.DataCase

  alias GoMovie.Business

  describe "plans" do
    alias GoMovie.Business.Plan

    @valid_attrs %{description: "some description", device_quantity: 42, duration: 42, name: "some name", price: "120.5", status: 42}
    @update_attrs %{description: "some updated description", device_quantity: 43, duration: 43, name: "some updated name", price: "456.7", status: 43}
    @invalid_attrs %{description: nil, device_quantity: nil, duration: nil, name: nil, price: nil, status: nil}

    def plan_fixture(attrs \\ %{}) do
      {:ok, plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_plan()

      plan
    end

    test "list_plans/0 returns all plans" do
      plan = plan_fixture()
      assert Business.list_plans() == [plan]
    end

    test "get_plan!/1 returns the plan with given id" do
      plan = plan_fixture()
      assert Business.get_plan!(plan.id) == plan
    end

    test "create_plan/1 with valid data creates a plan" do
      assert {:ok, %Plan{} = plan} = Business.create_plan(@valid_attrs)
      assert plan.description == "some description"
      assert plan.device_quantity == 42
      assert plan.duration == 42
      assert plan.name == "some name"
      assert plan.price == Decimal.new("120.5")
      assert plan.status == 42
    end

    test "create_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_plan(@invalid_attrs)
    end

    test "update_plan/2 with valid data updates the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{} = plan} = Business.update_plan(plan, @update_attrs)
      assert plan.description == "some updated description"
      assert plan.device_quantity == 43
      assert plan.duration == 43
      assert plan.name == "some updated name"
      assert plan.price == Decimal.new("456.7")
      assert plan.status == 43
    end

    test "update_plan/2 with invalid data returns error changeset" do
      plan = plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_plan(plan, @invalid_attrs)
      assert plan == Business.get_plan!(plan.id)
    end

    test "delete_plan/1 deletes the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{}} = Business.delete_plan(plan)
      assert_raise Ecto.NoResultsError, fn -> Business.get_plan!(plan.id) end
    end

    test "change_plan/1 returns a plan changeset" do
      plan = plan_fixture()
      assert %Ecto.Changeset{} = Business.change_plan(plan)
    end
  end

  describe "codes" do
    alias GoMovie.Business.Code

    @valid_attrs %{amount: "120.5", date_end: ~D[2010-04-17], description: "some description", name: "some name", quantity: 42, status: 42}
    @update_attrs %{amount: "456.7", date_end: ~D[2011-05-18], description: "some updated description", name: "some updated name", quantity: 43, status: 43}
    @invalid_attrs %{amount: nil, date_end: nil, description: nil, name: nil, quantity: nil, status: nil}

    def code_fixture(attrs \\ %{}) do
      {:ok, code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_code()

      code
    end

    test "list_codes/0 returns all codes" do
      code = code_fixture()
      assert Business.list_codes() == [code]
    end

    test "get_code!/1 returns the code with given id" do
      code = code_fixture()
      assert Business.get_code!(code.id) == code
    end

    test "create_code/1 with valid data creates a code" do
      assert {:ok, %Code{} = code} = Business.create_code(@valid_attrs)
      assert code.amount == Decimal.new("120.5")
      assert code.date_end == ~D[2010-04-17]
      assert code.description == "some description"
      assert code.name == "some name"
      assert code.quantity == 42
      assert code.status == 42
    end

    test "create_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_code(@invalid_attrs)
    end

    test "update_code/2 with valid data updates the code" do
      code = code_fixture()
      assert {:ok, %Code{} = code} = Business.update_code(code, @update_attrs)
      assert code.amount == Decimal.new("456.7")
      assert code.date_end == ~D[2011-05-18]
      assert code.description == "some updated description"
      assert code.name == "some updated name"
      assert code.quantity == 43
      assert code.status == 43
    end

    test "update_code/2 with invalid data returns error changeset" do
      code = code_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_code(code, @invalid_attrs)
      assert code == Business.get_code!(code.id)
    end

    test "delete_code/1 deletes the code" do
      code = code_fixture()
      assert {:ok, %Code{}} = Business.delete_code(code)
      assert_raise Ecto.NoResultsError, fn -> Business.get_code!(code.id) end
    end

    test "change_code/1 returns a code changeset" do
      code = code_fixture()
      assert %Ecto.Changeset{} = Business.change_code(code)
    end
  end
end
