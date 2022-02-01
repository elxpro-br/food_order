defmodule FoodOrderWeb.PageController do
  use FoodOrderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
