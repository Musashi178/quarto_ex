defmodule QuartoWeb.UserTest do
  use QuartoWeb.ModelCase

  alias QuartoWeb.User

  @valid_attrs %{password_hash: "some content", email: Faker.Internet.email, username: Faker.Internet.user_name}
  @invalid_attrs %{}

  setup do
    {:ok, existing_user} = Repo.insert User.changeset(%User{}, @valid_attrs)
    {:ok, existing_user: existing_user}
  end

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with already used email address", %{existing_user: existing_user} do
    new_user_params = existing_user
                        |> Map.from_struct
                        |> Map.delete(:id)
                        |> Map.put(:password_hash, "some other pw")
                        |> Map.put(:username, Faker.Internet.user_name)

    {:error, changeset} = Repo.insert User.changeset(%User{}, new_user_params)
    refute changeset.valid?
  end

  test "changeset with already used username", %{existing_user: existing_user} do
    new_user_params = existing_user
                        |> Map.from_struct
                        |> Map.delete(:id)
                        |> Map.put(:password_hash, "some other pw")
                        |> Map.put(:email, Faker.Internet.email)

    {:error, changeset} = Repo.insert User.changeset(%User{}, new_user_params)
    refute changeset.valid?
  end

  test "changeset with invalid email address" do
    changeset = User.changeset(%User{}, %{@valid_attrs | email: "no valid email"})
    refute changeset.valid?
  end
end
