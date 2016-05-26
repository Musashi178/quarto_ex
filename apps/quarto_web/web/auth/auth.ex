defmodule QuartoWeb.Auth do
  import Plug.Conn

  def init(opts) do

  end

  def call(conn, repo) do
    res = Guardian.Plug.current_resource(conn)
    user = res && res.current_user
    assign(conn, :current_user, user)
  end

end
