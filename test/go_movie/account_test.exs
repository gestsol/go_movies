defmodule GoMovie.AccountTest do
  use GoMovie.DataCase

  alias GoMovie.Account

  describe "roles" do
    alias GoMovie.Account.Role

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Account.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Account.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Account.create_role(@valid_attrs)
      assert role.description == "some description"
      assert role.name == "some name"
      assert role.status == 42
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Account.update_role(role, @update_attrs)
      assert role.description == "some updated description"
      assert role.name == "some updated name"
      assert role.status == 43
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_role(role, @invalid_attrs)
      assert role == Account.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Account.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Account.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Account.change_role(role)
    end
  end
end
