defmodule Quarto.Accounts.User do
  use Ecto.Schema
  
  schema "accounts_users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string

    timestamps()
  end
end
