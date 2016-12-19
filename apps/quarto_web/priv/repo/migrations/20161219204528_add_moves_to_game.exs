defmodule QuartoWeb.Repo.Migrations.AddMovesToGame do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :moves, {:array, :map}, default: []
    end
  end
end
