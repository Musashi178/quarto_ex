defmodule Quarto.Authorization.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Quarto.Repo
  alias Quarto.Accounts
  alias Quarto.Accounts.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Accounts.get_user(id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
