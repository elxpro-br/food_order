defmodule FoodOrderWeb.Admin.OrderLiveTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.Factory
  import Phoenix.LiveViewTest
  alias FoodOrder.Orders

  describe "test is order is loaded" do
    setup :register_and_log_in_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=layers]")

      assert has_element?(view, "#NOT_STARTED")
      assert has_element?(view, "#RECEIVED")
      assert has_element?(view, "#PREPARING")
      assert has_element?(view, "#DELIVERING")
      assert has_element?(view, "#DELIVERED")
    end

    test "change card to another place", %{conn: conn} do
      order = insert(:order)
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))

      assert has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}]")
      assert has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}]")
      assert has_element?(view, "[data-role=not-started-qty]", "1")
      assert has_element?(view, "[data-role=received-qty]", "0")
      Orders.update_order_status(order.id, "NOT_STARTED", "RECEIVED")

      send(view.pid, {:order_updated, %{status: :RECEIVED}, "NOT_STARTED"})

      refute has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}]")
      assert has_element?(view, "[data-role=order-status][data-id=RECEIVED#{order.id}]")
      assert has_element?(view, "[data-role=not-started-qty]", "0")
      assert has_element?(view, "[data-role=received-qty]", "1")
    end
  end
end
