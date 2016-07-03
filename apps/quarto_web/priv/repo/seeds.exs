# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QuartoWeb.Repo.insert!(%QuartoWeb.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias QuartoWeb.{Repo, User}

pw = "password"
for username <- ~w(player_one player_two player_three) do
  Repo.get_by(User, username: username) ||
    Repo.insert!(User.registration_changeset(%User{}, %{email: "#{username}@quarto.com", username: username, password: pw}))
end
