defmodule QuartoWeb.UserAuth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]


  def authenticate(email_or_username, password) do
    user = Repo.get_by(User, email: email_or_username) || Repo.get_by(User, username: email_or_username)

    cond do
      user && checkpw(password, user.password_hash) -> {:ok, user}
      user -> {:error, :unauthorized}
      true ->
        dummy_checkpw() # this hardens the authentication against timing attacks
        {:error, :not_found}
    end
  end
end
