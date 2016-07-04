defmodule QuartoWeb.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: QuartoWeb.Repo
  alias Faker

  def user_factory do
    %QuartoWeb.User{
      username: Faker.Internet.user_name(),
      email: Faker.Internet.email(),
      password_hash: Faker.Bitcoin.address()
    }
  end

  def user_registration_factory do
    %QuartoWeb.User{
      username: Faker.Internet.user_name(),
      email: Faker.Internet.email(),
      password: Faker.Bitcoin.address()
    }
  end
end
