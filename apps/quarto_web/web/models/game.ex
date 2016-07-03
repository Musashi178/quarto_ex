defmodule QuartoWeb.Game do
  use QuartoWeb.Web, :model

  schema "games" do
    belongs_to :player_one, QuartoWeb.User
    belongs_to :player_two, QuartoWeb.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
