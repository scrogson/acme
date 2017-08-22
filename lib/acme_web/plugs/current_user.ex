defmodule AcmeWeb.CurrentUser do
  import Plug.Conn
  alias Acme.UserManager

  def init(opts), do: opts

  def call(conn, _opts) do
    assign(conn, :current_user, get_user_from_session(conn))
  end

  defp get_user_from_session(conn) do
    case get_session(conn, :current_user_id) do
      nil -> nil
      val -> UserManager.get_user!(val)
    end
  end
end
