defmodule Quarto.Repo.Migrations.CreateQuarto.Accounts.User do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION citext;")
    create table(:accounts_users) do
      add :username, :string
      add :email, :citext
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:username])
    create unique_index(:accounts_users, [:email])
  end
end
