defmodule FoodOrderWeb.Customer.OrderLiveTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.HTML.Form, only: [humanize: 1]
  import Phoenix.LiveViewTest
  import FoodOrder.Factory
  alias FoodOrder.Orders

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
      assert has_element?(view, "##{order.id}")
      assert has_element?(view, "[data-role=details][data-id=#{order.id}]", order.address)
      assert has_element?(view, "[data-role=details][data-id=#{order.id}]", order.phone_number)

      assert has_element?(
               view,
               "[data-role=status][data-id=#{order.id}]",
               humanize(order.status)
             )

      assert has_element?(
               view,
               "[data-role=date][data-id=#{order.id}]",
               NaiveDateTime.to_string(order.updated_at)
             )
    end

    test "render change order status", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))

      assert has_element?(
               view,
               "[data-role=status][data-id=#{order.id}]",
               humanize(order.status)
             )

      {:ok, new_order} = Orders.update_order_status(order.id, "NOT_STARTED", "RECEIVED")
      send(view.pid, {:update_order_user_row, new_order})

      assert has_element?(
               view,
               "[data-role=status][data-id=#{new_order.id}]",
               humanize(new_order.status)
             )
    end
  end
end
