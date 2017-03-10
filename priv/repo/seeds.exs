# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Quarto.Repo.insert!(%Quarto.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Quarto.Repo
alias Quarto.Accounts.User

Repo.insert! %User{
  username: "Administrator",
  email: "admin@admin.com",
  password_hash: Comeonin.Bcrypt.hashpwsalt("admin")
}
