defmodule FoodOrderWeb.Admin.OrderLive.Layer.CardTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is card is loaded" do
    setup :register_and_log_in_admin

    test "render main elements", %{conn: conn} do
      card = %{id: "123"}
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert false == true
    end
  end
end
