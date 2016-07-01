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

pw = "password"
QuartoWeb.Repo.insert!(QuartoWeb.User.registration_changeset(%QuartoWeb.User{}, %{ email: "player_one@quarto.com", username: "player_one", password: pw}))
QuartoWeb.Repo.insert!(QuartoWeb.User.registration_changeset(%QuartoWeb.User{}, %{ email: "player_two@quarto.com", username: "player_two", password: pw}))
QuartoWeb.Repo.insert!(QuartoWeb.User.registration_changeset(%QuartoWeb.User{}, %{ email: "player_three@quarto.com", username: "player_three", password: pw}))
