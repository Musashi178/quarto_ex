defmodule QuartoWeb.UserAuthTest do
  use ExUnit.Case, async: false

  alias QuartoWeb.{Repo, User, UserAuth}

  setup_all do
    password = "super_secret_password"
    user_params = %{username: Faker.Internet.user_name, email: Faker.Internet.email, password: password}
    changeset = User.registration_changeset(%User{}, user_params)
    {:ok, existing_user} = Repo.insert(changeset)
    {:ok, existing_user: existing_user, password: password}
  end

  test "authenticate with non existing user_name fails" do
    nonexistent_user_name = Faker.Internet.user_name

    assert {:error, :not_found} == UserAuth.authenticate(nonexistent_user_name, "password")
  end

  test "authenticate with non existing email fails" do
    nonexistent_email = Faker.Internet.email

    assert {:error, :not_found} == UserAuth.authenticate(nonexistent_email, "password")
  end

  test "authenticate with existing user_name and valid password is successfull", %{existing_user: existing_user, password: password} do
    assert {:ok, _user} = UserAuth.authenticate(existing_user.username, password)
  end

  test "authenticate with existing email and valid password is successfull", %{existing_user: existing_user, password: password} do
    assert {:ok, _user} = UserAuth.authenticate(existing_user.email, password)
  end

  test "authenticate with existing user_name and invalid password fails", %{existing_user: existing_user} do
    assert {:error, :unauthorized} = UserAuth.authenticate(existing_user.username, "wrong_password")
  end

end
