defmodule QuartoWeb.UserTest do
  use QuartoWeb.ModelCase

  alias QuartoWeb.User

  @valid_attrs %{crypted_password: "some content", email: Faker.Internet.email, username: Faker.Internet.user_name}
  @invalid_attrs %{}

  setup_all do
    {:ok, existing_user} = Repo.insert struct(User, @valid_attrs)

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
    new_user = %User{existing_user | crypted_password: "some other pw", username: Faker.Internet.user_name}
    changeset = User.changeset(new_user)
    refute changeset.valid?
  end

  test "changeset with already used username", %{existing_user: existing_user} do
    new_user = %User{existing_user | crypted_password: "some other pw", email: Faker.Internet.email}
    changeset = User.changeset(new_user)
    refute changeset.valid?
  end

  test "changeset with invalid email address" do
    changeset = User.changeset(%User{}, %{@valid_attrs | email: "no valid email"})
    refute changeset.valid?
  end
end
