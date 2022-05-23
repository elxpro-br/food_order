defmodule FoodOrderWeb.Admin.OrderLive.SideMenuTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is side menu is loaded" do
    setup :register_and_log_in_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=side-title]", "Orders")

      assert has_element?(view, "[data-role=all-orders]", "All")
      assert has_element?(view, "[data-role=all-orders-qty]", "30")

      assert has_element?(view, "[data-role=received]", "Received")
      assert has_element?(view, "[data-role=received-qty]", "3")

      assert has_element?(view, "[data-role=preparing]", "Preparing")
      assert has_element?(view, "[data-role=preparing-qty]", "3")

      assert has_element?(view, "[data-role=delivering]", "Delivering")
      assert has_element?(view, "[data-role=delivering-qty]", "3")

      assert has_element?(view, "[data-role=delivered]", "Delivered")
      assert has_element?(view, "[data-role=delivered-qty]", "3")
    end
  end
end
