defmodule QuartoWeb.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player_one_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :player_two_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:games, [:player_one_id])
    create index(:games, [:player_two_id])

  end
end
