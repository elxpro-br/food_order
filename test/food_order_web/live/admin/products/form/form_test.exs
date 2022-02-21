defmodule FoodOrderWeb.Admin.Products.FormTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodOrder.Products

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new_product", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"
  end

  test "given a product when submit the form then return a message that has created the product",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    payload = %{name: "pumpking", description: "abc 123", price: 123, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new_product", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created"
    assert html =~ "pumpking"
  end

  test "given a product when submit the form then return changeset error ",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    payload = %{name: "pumpking", description: "abc 123", price: 123, size: "small"}
    assert {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new_product", product: payload)
           |> render_submit() =~ "has already been taken"
  end
end
