defmodule ArtikelWeb.PageController do
  use ArtikelWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
