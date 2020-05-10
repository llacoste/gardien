defmodule GardienOsUiWeb.PageController do
  use GardienOsUiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
