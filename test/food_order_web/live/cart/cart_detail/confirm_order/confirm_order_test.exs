defmodule FoodOrderWeb.CartLive.ConfirmOrderTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "create order with user authenticated", %{conn: conn} do
      product = insert(:product)
      main_route = Routes.main_path(conn, :index)
      {:ok, view, _html} = live(conn, main_route)

      product_element = build_product_element(product.id)
      add_product(view, product_element, conn)

      cart_route = Routes.cart_path(conn, :index)
      {:ok, view, _html} = live(conn, cart_route)

      {:ok, _view, html} =
        view
        |> form("#confirm-order-form", %{
          "phone_number" => "11231312312",
          "address" => "Rua abcd numero xpto"
        })
        |> render_submit()
        |> follow_redirect(conn, Routes.customer_order_path(conn, :index))

      assert html =~ "Order Created with Success"
    end

    test "error to create order", %{conn: conn} do
      product = insert(:product)
      main_route = Routes.main_path(conn, :index)
      {:ok, view, _html} = live(conn, main_route)

      product_element = build_product_element(product.id)
      add_product(view, product_element, conn)

      cart_route = Routes.cart_path(conn, :index)
      {:ok, view, _html} = live(conn, cart_route)

      {:ok, _view, html} =
        view
        |> form("#confirm-order-form", %{})
        |> render_submit()
        |> follow_redirect(conn, Routes.cart_path(conn, :index))

      assert html =~ "Something went wrong please verify your order"
    end
  end

  defp build_product_element(product_id),
    do: "[data-role=product-add][data-id=item-#{product_id}]"

  defp add_product(view, product_element, conn) do
    {:ok, view, _html} =
      view
      |> element(product_element)
      |> render_click()
      |> follow_redirect(conn, Routes.main_path(conn, :index))

    view
  end
end
