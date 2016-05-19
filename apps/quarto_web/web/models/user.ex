defmodule QuartoWeb.User do
  use QuartoWeb.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :crypted_password, :string

    timestamps
  end

  @required_fields ~w(email username crypted_password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
