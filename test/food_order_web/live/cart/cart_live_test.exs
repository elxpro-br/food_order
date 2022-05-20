defmodule FoodOrderWeb.CartLiveTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load page", %{conn: conn} do
    {:ok, _view, html} = live(conn, Routes.cart_path(conn, :index))
    assert html =~ "You Cart is Empty!!!"
  end
end
