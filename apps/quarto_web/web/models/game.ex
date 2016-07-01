defmodule QuartoWeb.Game do
  use QuartoWeb.Web, :model

  schema "game" do

    belongs_to :player_one, QuartoWeb.User
    belongs_to :player_two, QuartoWeb.User

    timestamps
  end

  @required_fields ~w(player_one player_two)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
