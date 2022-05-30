defmodule FoodOrderWeb.Customer.OrderLiveTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "test is order is loaded" do
    setup :register_and_log_in_user

    test "render when there is no orders", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))
      assert has_element?(view, "[data-role=section-title]", "All Orders")
      assert has_element?(view, "[data-role=no-orders]", "No orders found!")
    end

    test "render when there has orders", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))
      has_element?(view, "##{order.id}")
      has_element?(view, "[data-role=show-status][data-id=#{order.id}]", order.id)
      has_element?(view, "[data-role=details][data-id=#{order.id}]", order.address)
      has_element?(view, "[data-role=details][data-id=#{order.id}]", order.phone_number)
      has_element?(view, "[data-role=status][data-id=#{order.id}]", order.status)
      has_element?(view, "[data-role=date][data-id=#{order.id}]", order.updated_at)
    end
  end
end
