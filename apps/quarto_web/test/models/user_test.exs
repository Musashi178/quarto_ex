defmodule QuartoWeb.UserTest do
  use QuartoWeb.ModelCase

  import QuartoWeb.Factory

  alias QuartoWeb.User

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, params_for(:user))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, %{})
    refute changeset.valid?
  end

  test "changeset with already used email address" do
    existing_user = insert(:user)
    new_user_params = existing_user
                        |> Map.from_struct
                        |> Map.delete(:id)
                        |> Map.put(:password_hash, "some other pw")
                        |> Map.put(:username, Faker.Internet.user_name)

    {:error, changeset} = Repo.insert User.changeset(%User{}, new_user_params)
    refute changeset.valid?
  end

  test "changeset with already used username" do
    existing_user = insert(:user)
    new_user_params = existing_user
                        |> Map.from_struct
                        |> Map.delete(:id)
                        |> Map.put(:password_hash, "some other pw")
                        |> Map.put(:email, Faker.Internet.email)

    {:error, changeset} = Repo.insert User.changeset(%User{}, new_user_params)
    refute changeset.valid?
  end

  test "changeset with invalid email address" do
    changeset = User.changeset(%User{}, %{params_for(:user) | email: "no valid email"})
    refute changeset.valid?
  end
end
