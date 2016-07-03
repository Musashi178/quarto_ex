defmodule QuartoWeb.Game do
  use QuartoWeb.Web, :model

  schema "game" do

    belongs_to :player_one, QuartoWeb.User
    belongs_to :player_two, QuartoWeb.User

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
  end

end
