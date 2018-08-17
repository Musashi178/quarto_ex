defmodule Quarto.Accounts.Registration do
  use Ecto.Schema

  embedded_schema do
    field :username, :string
    field :email, :string
    field :password, :string
    field :password_confirmation, :string
  end
end
