defmodule FoodOrderWeb.Admin.OrderLive.SideMenuTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodOrder.Orders

  describe "test is side menu is loaded" do
    setup :register_and_log_in_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      all_status_orders = Orders.all_status_orders()
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=side-title]", "Orders")

      assert has_element?(view, "[data-role=all-orders]", "All")

      assert has_element?(
               view,
               "[data-role=all-orders-qty]",
               convert_to_string(all_status_orders.all)
             )

      assert has_element?(view, "[data-role=received]", "Received")

      assert has_element?(
               view,
               "[data-role=received-qty]",
               convert_to_string(all_status_orders.received)
             )

      assert has_element?(view, "[data-role=preparing]", "Preparing")

      assert has_element?(
               view,
               "[data-role=preparing-qty]",
               convert_to_string(all_status_orders.preparing)
             )

      assert has_element?(view, "[data-role=delivering]", "Delivering")

      assert has_element?(
               view,
               "[data-role=delivering-qty]",
               convert_to_string(all_status_orders.delivering)
             )

      assert has_element?(view, "[data-role=delivered]", "Delivered")

      assert has_element?(
               view,
               "[data-role=delivered-qty]",
               convert_to_string(all_status_orders.delivered)
             )
    end
  end

  defp convert_to_string(status_count), do: Integer.to_string(status_count)
end
