defmodule FoodOrderWeb.Admin.OrderLive.LayerTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  describe "test is layer is loaded" do
    setup :register_and_log_in_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#NOT_STARTED")
      assert has_element?(view, "[data-role=layer-title][data-id=NOT_STARTED]", "Not started")
    end

    test "change card to another place", %{conn: conn} do
      order = insert(:order)
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))

      assert has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}]")

      view
      |> element("#NOT_STARTED")
      |> render_hook("dropped", %{
        "new_status" => "NOT_STARTED",
        "old_status" => "NOT_STARTEd",
        "order_id" => order.id
      })

      assert has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}]")

      view
      |> element("#NOT_STARTED")
      |> render_hook("dropped", %{
        "new_status" => "PREPARING",
        "old_status" => "NOT_STARTED",
        "order_id" => order.id
      })

      refute has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}]")
      assert has_element?(view, "[data-role=order-status][data-id=PREPARING#{order.id}]")
    end
  end
end
