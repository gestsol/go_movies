defmodule GoMovie.ContentTest do
  use GoMovie.DataCase

  alias GoMovie.Content

  describe "resources" do
    alias GoMovie.Content.Resource

    @valid_attrs %{average: "120.5", chapter: 42, description: "some description", duration: 42, name: "some name", poster_url: "some poster_url", season: 42, status: 42, trailer_url: "some trailer_url", url: "some url", year: 42}
    @update_attrs %{average: "456.7", chapter: 43, description: "some updated description", duration: 43, name: "some updated name", poster_url: "some updated poster_url", season: 43, status: 43, trailer_url: "some updated trailer_url", url: "some updated url", year: 43}
    @invalid_attrs %{average: nil, chapter: nil, description: nil, duration: nil, name: nil, poster_url: nil, season: nil, status: nil, trailer_url: nil, url: nil, year: nil}

    def resource_fixture(attrs \\ %{}) do
      {:ok, resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_resource()

      resource
    end

    test "list_resources/0 returns all resources" do
      resource = resource_fixture()
      assert Content.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = resource_fixture()
      assert Content.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      assert {:ok, %Resource{} = resource} = Content.create_resource(@valid_attrs)
      assert resource.average == Decimal.new("120.5")
      assert resource.chapter == 42
      assert resource.description == "some description"
      assert resource.duration == 42
      assert resource.name == "some name"
      assert resource.poster_url == "some poster_url"
      assert resource.season == 42
      assert resource.status == 42
      assert resource.trailer_url == "some trailer_url"
      assert resource.url == "some url"
      assert resource.year == 42
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_resource(@invalid_attrs)
    end

    test "update_resource/2 with valid data updates the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{} = resource} = Content.update_resource(resource, @update_attrs)
      assert resource.average == Decimal.new("456.7")
      assert resource.chapter == 43
      assert resource.description == "some updated description"
      assert resource.duration == 43
      assert resource.name == "some updated name"
      assert resource.poster_url == "some updated poster_url"
      assert resource.season == 43
      assert resource.status == 43
      assert resource.trailer_url == "some updated trailer_url"
      assert resource.url == "some updated url"
      assert resource.year == 43
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_resource(resource, @invalid_attrs)
      assert resource == Content.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Content.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Content.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Content.change_resource(resource)
    end
  end

  describe "resource_types" do
    alias GoMovie.Content.ResourceType

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def resource_type_fixture(attrs \\ %{}) do
      {:ok, resource_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_resource_type()

      resource_type
    end

    test "list_resource_types/0 returns all resource_types" do
      resource_type = resource_type_fixture()
      assert Content.list_resource_types() == [resource_type]
    end

    test "get_resource_type!/1 returns the resource_type with given id" do
      resource_type = resource_type_fixture()
      assert Content.get_resource_type!(resource_type.id) == resource_type
    end

    test "create_resource_type/1 with valid data creates a resource_type" do
      assert {:ok, %ResourceType{} = resource_type} = Content.create_resource_type(@valid_attrs)
      assert resource_type.description == "some description"
      assert resource_type.name == "some name"
      assert resource_type.status == 42
    end

    test "create_resource_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_resource_type(@invalid_attrs)
    end

    test "update_resource_type/2 with valid data updates the resource_type" do
      resource_type = resource_type_fixture()
      assert {:ok, %ResourceType{} = resource_type} = Content.update_resource_type(resource_type, @update_attrs)
      assert resource_type.description == "some updated description"
      assert resource_type.name == "some updated name"
      assert resource_type.status == 43
    end

    test "update_resource_type/2 with invalid data returns error changeset" do
      resource_type = resource_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_resource_type(resource_type, @invalid_attrs)
      assert resource_type == Content.get_resource_type!(resource_type.id)
    end

    test "delete_resource_type/1 deletes the resource_type" do
      resource_type = resource_type_fixture()
      assert {:ok, %ResourceType{}} = Content.delete_resource_type(resource_type)
      assert_raise Ecto.NoResultsError, fn -> Content.get_resource_type!(resource_type.id) end
    end

    test "change_resource_type/1 returns a resource_type changeset" do
      resource_type = resource_type_fixture()
      assert %Ecto.Changeset{} = Content.change_resource_type(resource_type)
    end
  end

  describe "genders" do
    alias GoMovie.Content.Gender

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def gender_fixture(attrs \\ %{}) do
      {:ok, gender} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_gender()

      gender
    end

    test "list_genders/0 returns all genders" do
      gender = gender_fixture()
      assert Content.list_genders() == [gender]
    end

    test "get_gender!/1 returns the gender with given id" do
      gender = gender_fixture()
      assert Content.get_gender!(gender.id) == gender
    end

    test "create_gender/1 with valid data creates a gender" do
      assert {:ok, %Gender{} = gender} = Content.create_gender(@valid_attrs)
      assert gender.description == "some description"
      assert gender.name == "some name"
      assert gender.status == 42
    end

    test "create_gender/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_gender(@invalid_attrs)
    end

    test "update_gender/2 with valid data updates the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{} = gender} = Content.update_gender(gender, @update_attrs)
      assert gender.description == "some updated description"
      assert gender.name == "some updated name"
      assert gender.status == 43
    end

    test "update_gender/2 with invalid data returns error changeset" do
      gender = gender_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_gender(gender, @invalid_attrs)
      assert gender == Content.get_gender!(gender.id)
    end

    test "delete_gender/1 deletes the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{}} = Content.delete_gender(gender)
      assert_raise Ecto.NoResultsError, fn -> Content.get_gender!(gender.id) end
    end

    test "change_gender/1 returns a gender changeset" do
      gender = gender_fixture()
      assert %Ecto.Changeset{} = Content.change_gender(gender)
    end
  end

  describe "resource_genders" do
    alias GoMovie.Content.ResourceGender

    @valid_attrs %{status: 42}
    @update_attrs %{status: 43}
    @invalid_attrs %{status: nil}

    def resource_gender_fixture(attrs \\ %{}) do
      {:ok, resource_gender} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_resource_gender()

      resource_gender
    end

    test "list_resource_genders/0 returns all resource_genders" do
      resource_gender = resource_gender_fixture()
      assert Content.list_resource_genders() == [resource_gender]
    end

    test "get_resource_gender!/1 returns the resource_gender with given id" do
      resource_gender = resource_gender_fixture()
      assert Content.get_resource_gender!(resource_gender.id) == resource_gender
    end

    test "create_resource_gender/1 with valid data creates a resource_gender" do
      assert {:ok, %ResourceGender{} = resource_gender} = Content.create_resource_gender(@valid_attrs)
      assert resource_gender.status == 42
    end

    test "create_resource_gender/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_resource_gender(@invalid_attrs)
    end

    test "update_resource_gender/2 with valid data updates the resource_gender" do
      resource_gender = resource_gender_fixture()
      assert {:ok, %ResourceGender{} = resource_gender} = Content.update_resource_gender(resource_gender, @update_attrs)
      assert resource_gender.status == 43
    end

    test "update_resource_gender/2 with invalid data returns error changeset" do
      resource_gender = resource_gender_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_resource_gender(resource_gender, @invalid_attrs)
      assert resource_gender == Content.get_resource_gender!(resource_gender.id)
    end

    test "delete_resource_gender/1 deletes the resource_gender" do
      resource_gender = resource_gender_fixture()
      assert {:ok, %ResourceGender{}} = Content.delete_resource_gender(resource_gender)
      assert_raise Ecto.NoResultsError, fn -> Content.get_resource_gender!(resource_gender.id) end
    end

    test "change_resource_gender/1 returns a resource_gender changeset" do
      resource_gender = resource_gender_fixture()
      assert %Ecto.Changeset{} = Content.change_resource_gender(resource_gender)
    end
  end
end
