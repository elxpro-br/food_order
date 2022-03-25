defmodule FoodOrderWeb.Admin.Product.PaginateTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "test default page product" do
    setup :register_and_log_in_admin

    test "clicking next, preview, and page",
         %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      view
      |> element("[data-role=paginate][data-id=next]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=2&per_page=4&sort_by=updated_at&sort_order=desc&name="
      )

      view
      |> element("[data-role=paginate][data-id=prev]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=1&per_page=4&sort_by=updated_at&sort_order=desc&name="
      )

      view
      |> element("[data-role=paginate][data-id=2]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=2&per_page=4&sort_by=updated_at&sort_order=desc&name="
      )

      view
      |> element("[data-role=paginate][data-id=3]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=3&per_page=4&sort_by=updated_at&sort_order=desc&name="
      )
    end

    test "test using url params",
         %{conn: conn} do
      [product_1, product_2] = for _ <- 1..2, do: insert(:product)

      {:ok, view, _html} =
        live(conn, Routes.admin_product_path(conn, :index, page: 1, per_page: 1))

      assert has_element?(view, "[data-role=product-item][data-id=#{product_1.id}]")
      refute has_element?(view, "[data-role=product-item][data-id=#{product_2.id}]")

      {:ok, view, _html} =
        live(conn, Routes.admin_product_path(conn, :index, page: 2, per_page: 1))

      refute has_element?(view, "[data-role=product-item][data-id=#{product_1.id}]")
      assert has_element?(view, "[data-role=product-item][data-id=#{product_2.id}]")
    end
  end
end
