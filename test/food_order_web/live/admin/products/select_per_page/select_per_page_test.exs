defmodule FoodOrderWeb.Admin.Product.SelectPerPageTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "test default page product" do
    setup :register_and_log_in_admin

    test "change per page",
         %{conn: conn} do
      [product_1, product_2, product_3, product_4, product_5] =
        for _ <- 1..5, do: insert(:product)

      {:ok, view, _html} =
        live(conn, Routes.admin_product_path(conn, :index, page: 1, per_page: 2))

      assert has_element?(view, "[data-role=product-item][data-id=#{product_1.id}]")
      assert has_element?(view, "[data-role=product-item][data-id=#{product_2.id}]")
      refute has_element?(view, "[data-role=product-item][data-id=#{product_3.id}]")
      refute has_element?(view, "[data-role=product-item][data-id=#{product_4.id}]")
      refute has_element?(view, "[data-role=product-item][data-id=#{product_5.id}]")

      view
      |> form("#per-page", %{"per-page-select" => "5"})
      |> render_change()

      assert has_element?(view, "[data-role=product-item][data-id=#{product_1.id}]")
      assert has_element?(view, "[data-role=product-item][data-id=#{product_2.id}]")
      assert has_element?(view, "[data-role=product-item][data-id=#{product_3.id}]")
      assert has_element?(view, "[data-role=product-item][data-id=#{product_4.id}]")
      assert has_element?(view, "[data-role=product-item][data-id=#{product_5.id}]")
    end
  end
end
