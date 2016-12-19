defmodule QuartoWeb.Auth do
  import Plug.Conn

  def init(_opts) do
  end

  def call(conn, _repo) do
    current_user = Guardian.Plug.current_resource(conn)
    assign(conn, :current_user, current_user)
  end

end
