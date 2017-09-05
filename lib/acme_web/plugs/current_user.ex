defmodule AcmeWeb.CurrentUser do
  import Plug.Conn
  alias Acme.UserManager

  def init(opts), do: opts

  def call(conn, _opts) do
    user = get_user_from_session(conn)
    token = user_token(conn, user)

    conn
    |> assign(:current_user, user)
    |> assign(:current_user_token, token)
  end

  defp get_user_from_session(conn) do
    case get_session(conn, :current_user_id) do
      nil -> nil
      val -> UserManager.get_user!(val)
    end
  end

  defp user_token(conn, %{id: id}),
    do: Phoenix.Token.sign(conn, "user socket", id)
  defp user_token(_, _), do: "null"
end
