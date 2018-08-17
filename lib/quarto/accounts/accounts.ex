defmodule Quarto.Accounts do

import Comeonin.Bcrypt

  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Quarto.Repo

  alias Quarto.Accounts.{User, Registration}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
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
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.
  """
  def get_user(id), do: Repo.get(User, id)


  @doc """
  Gets a single user by its email.
  """
  def get_user_by_email(nil), do: nil
  def get_user_by_email(email), do: Repo.get_by(User, email: email)


  defp create_user(attrs \\ %{}) do
    %User{}
    |> user_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(user, %{field: value})
      {:ok, %User{}}

      iex> create_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs \\ %{}) do
    chset = registration_changeset(%Registration{}, attrs)

    user_registration_transaction = Ecto.Multi.new()
      |> Ecto.Multi.run(:reg, &apply_registration(&1, chset))
      |> Ecto.Multi.run(:user, fn ops -> create_user(to_user_attrs(ops.reg)) end)

    case Repo.transaction(user_registration_transaction) do
      {:error, :reg, c, _} -> {:error, c}
      {:error, :user, c, _} -> {:error, %{chset | errors: c.errors, valid?: c.valid?}}
      {:ok, %{user: user}} -> {:ok, user}
    end

  end

  defp apply_registration(_changes, changeset) do
    if changeset.valid? do
      {:ok, apply_changes(changeset)}
    else
      {:error, changeset}
    end
  end

  defp to_user_attrs(%Registration{} = reg) do
    reg
      |> Map.take([:email, :username])
      |> Map.put(:password_hash, create_password_hash(reg.password))
  end

  defp create_password_hash(pw) do
    Comeonin.Bcrypt.hashpwsalt(pw)
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
    |> user_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

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
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    user_changeset(user, %{})
  end

  defp user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password_hash])
    |> validate_required([:username, :email, :password_hash])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  defp registration_changeset(%Registration{} = registration, attrs) do
    registration
    |> cast(attrs, [:username, :email, :password, :password_confirmation])
    |> validate_required([:password])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password, required: true)
  end

  def authenticate_user(%Ueberauth.Auth{provider: :identity} = auth) do
    auth.uid
    |> get_user_by_email
    |> authorize(auth)
  end

  defp authorize(nil, _auth), do: {:error, "Invalid username or password"}
  defp authorize(user, auth) do
    auth.credentials.other.password
    |> checkpw(user.password_hash)
    |> resolve_authorization(user)
  end

  defp resolve_authorization(false, _user), do: {:error, "Invalid username or password"}
  defp resolve_authorization(true, user), do: {:ok, user}
end
