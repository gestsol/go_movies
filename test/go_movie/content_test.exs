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
end
