defmodule Quarto.AccountsTest do
  use Quarto.DataCase

  alias Quarto.Accounts
  alias Quarto.Accounts.User

  @register_user_attrs %{email: "some email", password: "some password", password_confirmation: "some password", username: "some username"}
  @update_attrs %{email: "some updated email", username: "some updated username"}
  @invalid_register_user_attrs %{email: nil, password: nil, password_confirmation: nil, username: nil}


  def fixture(:user, attrs \\ @register_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  test "list_users/1 returns all users" do
    user = fixture(:user)
    assert Accounts.list_users() == [user]
  end

  test "get_user! returns the user with given id" do
    user = fixture(:user)
    assert Accounts.get_user!(user.id) == user
  end

  test "get_user_by_email return the user with the given email" do
    user = fixture(:user)
    assert Accounts.get_user_by_email(user.email) == user
  end

  test "register_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Accounts.register_user(@register_user_attrs)

    assert user.email == "some email"
    assert user.username == "some username"
  end

  test "register_user/1 with not matching passwords returns error changeset" do
    assert {:error, %Ecto.Changeset{} = cs} = Accounts.register_user(%{@register_user_attrs | password: "my_simple_pw", password_confirmation: "no_match"})
    refute cs.valid?
  end

  test "register_user/1 with too short password returns error changeset" do
      assert {:error, %Ecto.Changeset{} = cs} = Accounts.register_user(%{@register_user_attrs | password: "shrt", password_confirmation: "shrt"})
      refute cs.valid?
  end

  test "register_user/1 with empty username returns error changeset" do
      assert {:error, %Ecto.Changeset{} = cs} = Accounts.register_user(%{@register_user_attrs | username: nil})
      refute cs.valid?
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user)
    assert {:ok, user} = Accounts.update_user(user, @update_attrs)
    assert %User{} = user

    assert user.email == "some updated email"
    assert user.username == "some updated username"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user)
    assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_register_user_attrs)
    assert user == Accounts.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user)
    assert {:ok, %User{}} = Accounts.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user)
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end
end
