defmodule FoodOrderWeb.CartLive.CartDetailTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "load cart details page", %{conn: conn} do
      product = insert(:product)
      main_route = Routes.main_path(conn, :index)
      {:ok, view, _html} = live(conn, main_route)
      product_element = "[data-role=product-add][data-id=item-#{product.id}]"
      assert has_element?(view, product_element)

      view
      |> element(product_element)
      |> render_click()
      |> follow_redirect(conn, main_route)

      cart_route = Routes.cart_path(conn, :index)
      {:ok, view, _html} = live(conn, cart_route)

      assert has_element?(view, "[data-role=cart-title]", "Order Detail")
    end
  end
end
