defmodule QuartoWeb.UserAuthTest do
  use ExUnit.Case, async: false

  import QuartoWeb.Factory

  alias QuartoWeb.{Repo, User, UserAuth}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(QuartoWeb.Repo)

    user_params = params_for(:user_registration)
    changeset = User.registration_changeset(%User{}, user_params)
    {:ok, existing_user} = Repo.insert(changeset)
    {:ok, existing_user: existing_user, password: user_params.password}
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
