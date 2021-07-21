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
end
