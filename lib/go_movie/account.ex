defmodule GoMovie.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias GoMovie.Repo

  alias GoMovie.Account.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  def get_user_role!() do
    from(r in Role, where: r.name == "user")
    |> Repo.one!()
  end

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias GoMovie.Account.User

  def authenticate_user(email, plain_pass) do
    User.authenticate(email, plain_pass)
  end

  def authenticate_user(google_auth_id) do
    User.authenticate(google_auth_id)
  end

  def authenticate_user_facebook(facebook_auth_id) do
    User.authenticate_facebook(facebook_auth_id)
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_users(query) do
    Repo.all(query)
  end
  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.get!(User, id)
    |> Repo.preload(:role)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias GoMovie.Account.BenefitRequest

  @doc """
  Returns the list of benefit_requests.

  ## Examples

      iex> list_benefit_requests()
      [%BenefitRequest{}, ...]

  """
  def list_benefit_requests do
    Repo.all(BenefitRequest)
  end

  @doc """
  Gets a single benefit_request.

  Raises `Ecto.NoResultsError` if the Benefit request does not exist.

  ## Examples

      iex> get_benefit_request!(123)
      %BenefitRequest{}

      iex> get_benefit_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_benefit_request!(id), do: Repo.get!(BenefitRequest, id)

  @doc """
  Creates a benefit_request.

  ## Examples

      iex> create_benefit_request(%{field: value})
      {:ok, %BenefitRequest{}}

      iex> create_benefit_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_benefit_request(attrs \\ %{}) do
    %BenefitRequest{}
    |> BenefitRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a benefit_request.

  ## Examples

      iex> update_benefit_request(benefit_request, %{field: new_value})
      {:ok, %BenefitRequest{}}

      iex> update_benefit_request(benefit_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_benefit_request(%BenefitRequest{} = benefit_request, attrs) do
    benefit_request
    |> BenefitRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a benefit_request.

  ## Examples

      iex> delete_benefit_request(benefit_request)
      {:ok, %BenefitRequest{}}

      iex> delete_benefit_request(benefit_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_benefit_request(%BenefitRequest{} = benefit_request) do
    Repo.delete(benefit_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking benefit_request changes.

  ## Examples

      iex> change_benefit_request(benefit_request)
      %Ecto.Changeset{data: %BenefitRequest{}}

  """
  def change_benefit_request(%BenefitRequest{} = benefit_request, attrs \\ %{}) do
    BenefitRequest.changeset(benefit_request, attrs)
  end
end
