defmodule AcmeWeb.PageController do
  use AcmeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
