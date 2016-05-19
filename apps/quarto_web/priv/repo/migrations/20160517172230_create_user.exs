defmodule QuartoWeb.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :email, :string
      add :crypted_password, :string

      timestamps
    end
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])


  end
end
