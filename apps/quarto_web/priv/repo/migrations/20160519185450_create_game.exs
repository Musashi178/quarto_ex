defmodule QuartoWeb.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:game, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player_one_id, references(:users, type: :binary_id)
      add :player_two_id, references(:users, type: :binary_id)

      timestamps
    end

  end
end
