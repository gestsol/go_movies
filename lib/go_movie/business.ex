defmodule GoMovie.Business do
  @moduledoc """
  The Business context.
  """

  import Ecto.Query, warn: false
  alias GoMovie.Repo

  alias GoMovie.Business.Plan

  @doc """
  Returns the list of plans.

  ## Examples

      iex> list_plans()
      [%Plan{}, ...]

  """
  def list_plans do
    Repo.all(Plan)
  end

  @doc """
  Gets a single plan.

  Raises `Ecto.NoResultsError` if the Plan does not exist.

  ## Examples

      iex> get_plan!(123)
      %Plan{}

      iex> get_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plan!(id), do: Repo.get!(Plan, id)

  @doc """
  Creates a plan.

  ## Examples

      iex> create_plan(%{field: value})
      {:ok, %Plan{}}

      iex> create_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plan(attrs \\ %{}) do
    %Plan{}
    |> Plan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plan.

  ## Examples

      iex> update_plan(plan, %{field: new_value})
      {:ok, %Plan{}}

      iex> update_plan(plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plan(%Plan{} = plan, attrs) do
    plan
    |> Plan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plan.

  ## Examples

      iex> delete_plan(plan)
      {:ok, %Plan{}}

      iex> delete_plan(plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plan(%Plan{} = plan) do
    Repo.delete(plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plan changes.

  ## Examples

      iex> change_plan(plan)
      %Ecto.Changeset{data: %Plan{}}

  """
  def change_plan(%Plan{} = plan, attrs \\ %{}) do
    Plan.changeset(plan, attrs)
  end

  alias GoMovie.Business.Code

  @doc """
  Returns the list of codes.

  ## Examples

      iex> list_codes()
      [%Code{}, ...]

  """
  def list_codes do
    Repo.all(Code)
  end

  @doc """
  Gets a single code.

  Raises `Ecto.NoResultsError` if the Code does not exist.

  ## Examples

      iex> get_code!(123)
      %Code{}

      iex> get_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_code!(id), do: Repo.get!(Code, id)

  @doc """
  Creates a code.

  ## Examples

      iex> create_code(%{field: value})
      {:ok, %Code{}}

      iex> create_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_code(attrs \\ %{}) do
    %Code{}
    |> Code.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a code.

  ## Examples

      iex> update_code(code, %{field: new_value})
      {:ok, %Code{}}

      iex> update_code(code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_code(%Code{} = code, attrs) do
    code
    |> Code.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a code.

  ## Examples

      iex> delete_code(code)
      {:ok, %Code{}}

      iex> delete_code(code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_code(%Code{} = code) do
    Repo.delete(code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking code changes.

  ## Examples

      iex> change_code(code)
      %Ecto.Changeset{data: %Code{}}

  """
  def change_code(%Code{} = code, attrs \\ %{}) do
    Code.changeset(code, attrs)
  end

  alias GoMovie.Business.UserPlan

  @doc """
  Returns the list of user_plans.

  ## Examples

      iex> list_user_plans()
      [%UserPlan{}, ...]

  """
  def list_user_plans do
    Repo.all(UserPlan)
  end

  @doc """
  Gets a single user_plan.

  Raises `Ecto.NoResultsError` if the User plan does not exist.

  ## Examples

      iex> get_user_plan!(123)
      %UserPlan{}

      iex> get_user_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_plan!(user_id, plan_id), do: Repo.get_by!(UserPlan, user_id: user_id, plan_id: plan_id)


  @doc """
  Creates a user_plan.

  ## Examples

      iex> create_user_plan(%{field: value})
      {:ok, %UserPlan{}}

      iex> create_user_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_plan(attrs \\ %{}) do
    %UserPlan{}
    |> UserPlan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_plan.

  ## Examples

      iex> update_user_plan(user_plan, %{field: new_value})
      {:ok, %UserPlan{}}

      iex> update_user_plan(user_plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_plan(%UserPlan{} = user_plan, attrs) do
    user_plan
    |> UserPlan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_plan.

  ## Examples

      iex> delete_user_plan(user_plan)
      {:ok, %UserPlan{}}

      iex> delete_user_plan(user_plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_plan(%UserPlan{} = user_plan) do
    Repo.delete(user_plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_plan changes.

  ## Examples

      iex> change_user_plan(user_plan)
      %Ecto.Changeset{data: %UserPlan{}}

  """
  def change_user_plan(%UserPlan{} = user_plan, attrs \\ %{}) do
    UserPlan.changeset(user_plan, attrs)
  end
end
