defmodule GoMovie.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias GoMovie.Repo

  alias GoMovie.Content.Resource

  @doc """
  Returns the list of resources.

  ## Examples

      iex> list_resources()
      [%Resource{}, ...]

  """
  def list_resources do
    Repo.all(Resource)
  end

  @doc """
  Gets a single resource.

  Raises `Ecto.NoResultsError` if the Resource does not exist.

  ## Examples

      iex> get_resource!(123)
      %Resource{}

      iex> get_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource!(id), do: Repo.get!(Resource, id)

  @doc """
  Creates a resource.

  ## Examples

      iex> create_resource(%{field: value})
      {:ok, %Resource{}}

      iex> create_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource(attrs \\ %{}) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a resource.

  ## Examples

      iex> update_resource(resource, %{field: new_value})
      {:ok, %Resource{}}

      iex> update_resource(resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a resource.

  ## Examples

      iex> delete_resource(resource)
      {:ok, %Resource{}}

      iex> delete_resource(resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource(%Resource{} = resource) do
    Repo.delete(resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource changes.

  ## Examples

      iex> change_resource(resource)
      %Ecto.Changeset{data: %Resource{}}

  """
  def change_resource(%Resource{} = resource, attrs \\ %{}) do
    Resource.changeset(resource, attrs)
  end

  alias GoMovie.Content.ResourceType

  @doc """
  Returns the list of resource_types.

  ## Examples

      iex> list_resource_types()
      [%ResourceType{}, ...]

  """
  def list_resource_types do
    Repo.all(ResourceType)
  end

  @doc """
  Gets a single resource_type.

  Raises `Ecto.NoResultsError` if the Resource type does not exist.

  ## Examples

      iex> get_resource_type!(123)
      %ResourceType{}

      iex> get_resource_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource_type!(id), do: Repo.get!(ResourceType, id)

  @doc """
  Creates a resource_type.

  ## Examples

      iex> create_resource_type(%{field: value})
      {:ok, %ResourceType{}}

      iex> create_resource_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource_type(attrs \\ %{}) do
    %ResourceType{}
    |> ResourceType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a resource_type.

  ## Examples

      iex> update_resource_type(resource_type, %{field: new_value})
      {:ok, %ResourceType{}}

      iex> update_resource_type(resource_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource_type(%ResourceType{} = resource_type, attrs) do
    resource_type
    |> ResourceType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a resource_type.

  ## Examples

      iex> delete_resource_type(resource_type)
      {:ok, %ResourceType{}}

      iex> delete_resource_type(resource_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource_type(%ResourceType{} = resource_type) do
    Repo.delete(resource_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource_type changes.

  ## Examples

      iex> change_resource_type(resource_type)
      %Ecto.Changeset{data: %ResourceType{}}

  """
  def change_resource_type(%ResourceType{} = resource_type, attrs \\ %{}) do
    ResourceType.changeset(resource_type, attrs)
  end
end
