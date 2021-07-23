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

  describe "user_plans" do
    alias GoMovie.Business.UserPlan

    @valid_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], status: 42}
    @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], status: 43}
    @invalid_attrs %{date_end: nil, date_start: nil, status: nil}

    def user_plan_fixture(attrs \\ %{}) do
      {:ok, user_plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_user_plan()

      user_plan
    end

    test "list_user_plans/0 returns all user_plans" do
      user_plan = user_plan_fixture()
      assert Business.list_user_plans() == [user_plan]
    end

    test "get_user_plan!/1 returns the user_plan with given id" do
      user_plan = user_plan_fixture()
      assert Business.get_user_plan!(user_plan.id) == user_plan
    end

    test "create_user_plan/1 with valid data creates a user_plan" do
      assert {:ok, %UserPlan{} = user_plan} = Business.create_user_plan(@valid_attrs)
      assert user_plan.date_end == ~D[2010-04-17]
      assert user_plan.date_start == ~D[2010-04-17]
      assert user_plan.status == 42
    end

    test "create_user_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_user_plan(@invalid_attrs)
    end

    test "update_user_plan/2 with valid data updates the user_plan" do
      user_plan = user_plan_fixture()
      assert {:ok, %UserPlan{} = user_plan} = Business.update_user_plan(user_plan, @update_attrs)
      assert user_plan.date_end == ~D[2011-05-18]
      assert user_plan.date_start == ~D[2011-05-18]
      assert user_plan.status == 43
    end

    test "update_user_plan/2 with invalid data returns error changeset" do
      user_plan = user_plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_user_plan(user_plan, @invalid_attrs)
      assert user_plan == Business.get_user_plan!(user_plan.id)
    end

    test "delete_user_plan/1 deletes the user_plan" do
      user_plan = user_plan_fixture()
      assert {:ok, %UserPlan{}} = Business.delete_user_plan(user_plan)
      assert_raise Ecto.NoResultsError, fn -> Business.get_user_plan!(user_plan.id) end
    end

    test "change_user_plan/1 returns a user_plan changeset" do
      user_plan = user_plan_fixture()
      assert %Ecto.Changeset{} = Business.change_user_plan(user_plan)
    end
  end

  describe "purchases" do
    alias GoMovie.Business.Purchase

    @valid_attrs %{amount: "120.5", date: ~D[2010-04-17], description: "some description", status: 42}
    @update_attrs %{amount: "456.7", date: ~D[2011-05-18], description: "some updated description", status: 43}
    @invalid_attrs %{amount: nil, date: nil, description: nil, status: nil}

    def purchase_fixture(attrs \\ %{}) do
      {:ok, purchase} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_purchase()

      purchase
    end

    test "list_purchases/0 returns all purchases" do
      purchase = purchase_fixture()
      assert Business.list_purchases() == [purchase]
    end

    test "get_purchase!/1 returns the purchase with given id" do
      purchase = purchase_fixture()
      assert Business.get_purchase!(purchase.id) == purchase
    end

    test "create_purchase/1 with valid data creates a purchase" do
      assert {:ok, %Purchase{} = purchase} = Business.create_purchase(@valid_attrs)
      assert purchase.amount == Decimal.new("120.5")
      assert purchase.date == ~D[2010-04-17]
      assert purchase.description == "some description"
      assert purchase.status == 42
    end

    test "create_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_purchase(@invalid_attrs)
    end

    test "update_purchase/2 with valid data updates the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{} = purchase} = Business.update_purchase(purchase, @update_attrs)
      assert purchase.amount == Decimal.new("456.7")
      assert purchase.date == ~D[2011-05-18]
      assert purchase.description == "some updated description"
      assert purchase.status == 43
    end

    test "update_purchase/2 with invalid data returns error changeset" do
      purchase = purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_purchase(purchase, @invalid_attrs)
      assert purchase == Business.get_purchase!(purchase.id)
    end

    test "delete_purchase/1 deletes the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{}} = Business.delete_purchase(purchase)
      assert_raise Ecto.NoResultsError, fn -> Business.get_purchase!(purchase.id) end
    end

    test "change_purchase/1 returns a purchase changeset" do
      purchase = purchase_fixture()
      assert %Ecto.Changeset{} = Business.change_purchase(purchase)
    end
  end
end
