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

  describe "users" do
    alias GoMovie.Account.User

    @valid_attrs %{address: "some address", city: "some city", country: "some country", email: "some email", image_url: "some image_url", lastname: "some lastname", name: "some name", password_hash: "some password_hash", phone_number: "some phone_number", postal_code: "some postal_code", profile_description: "some profile_description", sesion_counter: 42, status: "some status"}
    @update_attrs %{address: "some updated address", city: "some updated city", country: "some updated country", email: "some updated email", image_url: "some updated image_url", lastname: "some updated lastname", name: "some updated name", password_hash: "some updated password_hash", phone_number: "some updated phone_number", postal_code: "some updated postal_code", profile_description: "some updated profile_description", sesion_counter: 43, status: "some updated status"}
    @invalid_attrs %{address: nil, city: nil, country: nil, email: nil, image_url: nil, lastname: nil, name: nil, password_hash: nil, phone_number: nil, postal_code: nil, profile_description: nil, sesion_counter: nil, status: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.address == "some address"
      assert user.city == "some city"
      assert user.country == "some country"
      assert user.email == "some email"
      assert user.image_url == "some image_url"
      assert user.lastname == "some lastname"
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.phone_number == "some phone_number"
      assert user.postal_code == "some postal_code"
      assert user.profile_description == "some profile_description"
      assert user.sesion_counter == 42
      assert user.status == "some status"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.address == "some updated address"
      assert user.city == "some updated city"
      assert user.country == "some updated country"
      assert user.email == "some updated email"
      assert user.image_url == "some updated image_url"
      assert user.lastname == "some updated lastname"
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
      assert user.phone_number == "some updated phone_number"
      assert user.postal_code == "some updated postal_code"
      assert user.profile_description == "some updated profile_description"
      assert user.sesion_counter == 43
      assert user.status == "some updated status"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "benefit_requests" do
    alias GoMovie.Account.BenefitRequest

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number", rut: "some rut"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number", rut: "some updated rut"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, phone_number: nil, rut: nil}

    def benefit_request_fixture(attrs \\ %{}) do
      {:ok, benefit_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_benefit_request()

      benefit_request
    end

    test "list_benefit_requests/0 returns all benefit_requests" do
      benefit_request = benefit_request_fixture()
      assert Account.list_benefit_requests() == [benefit_request]
    end

    test "get_benefit_request!/1 returns the benefit_request with given id" do
      benefit_request = benefit_request_fixture()
      assert Account.get_benefit_request!(benefit_request.id) == benefit_request
    end

    test "create_benefit_request/1 with valid data creates a benefit_request" do
      assert {:ok, %BenefitRequest{} = benefit_request} = Account.create_benefit_request(@valid_attrs)
      assert benefit_request.email == "some email"
      assert benefit_request.first_name == "some first_name"
      assert benefit_request.last_name == "some last_name"
      assert benefit_request.phone_number == "some phone_number"
      assert benefit_request.rut == "some rut"
    end

    test "create_benefit_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_benefit_request(@invalid_attrs)
    end

    test "update_benefit_request/2 with valid data updates the benefit_request" do
      benefit_request = benefit_request_fixture()
      assert {:ok, %BenefitRequest{} = benefit_request} = Account.update_benefit_request(benefit_request, @update_attrs)
      assert benefit_request.email == "some updated email"
      assert benefit_request.first_name == "some updated first_name"
      assert benefit_request.last_name == "some updated last_name"
      assert benefit_request.phone_number == "some updated phone_number"
      assert benefit_request.rut == "some updated rut"
    end

    test "update_benefit_request/2 with invalid data returns error changeset" do
      benefit_request = benefit_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_benefit_request(benefit_request, @invalid_attrs)
      assert benefit_request == Account.get_benefit_request!(benefit_request.id)
    end

    test "delete_benefit_request/1 deletes the benefit_request" do
      benefit_request = benefit_request_fixture()
      assert {:ok, %BenefitRequest{}} = Account.delete_benefit_request(benefit_request)
      assert_raise Ecto.NoResultsError, fn -> Account.get_benefit_request!(benefit_request.id) end
    end

    test "change_benefit_request/1 returns a benefit_request changeset" do
      benefit_request = benefit_request_fixture()
      assert %Ecto.Changeset{} = Account.change_benefit_request(benefit_request)
    end
  end
end
