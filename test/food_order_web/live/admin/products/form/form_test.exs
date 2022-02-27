defmodule FoodOrderWeb.Admin.Products.FormTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodOrder.Products
  import FoodOrder.Factory

  test "given a product that has already exist when try to update without informations return an error",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> element("[data-role=edit-product][data-id=#{product.id}]") |> render_click()
    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view
           |> form("##{product.id}", product: %{name: nil})
           |> render_submit() =~ "can&#39;t be blank"
  end

  test "given a product that has already exist when click to edit then open the modal and execute an action",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> element("[data-role=edit-product][data-id=#{product.id}]") |> render_click()

    assert view |> has_element?("#modal")

    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view
           |> form("##{product.id}", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"

    {:ok, view, html} =
      view
      |> form("##{product.id}", product: %{name: "abobora"})
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product updated!"

    assert view |> has_element?("[data-role=product-name][data-id=#{product.id}]", "abobora")
  end

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"
  end

  test "given a product when submit the form then return a message that has created the product",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)
    payload = %{name: "pumpking", description: "abc 123", price: 123, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created"
    assert html =~ "pumpking"
  end

  test "given a product when submit the form then return changeset error ",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    open_modal(view)

    payload = %{name: "pumpking", description: "abc 123", price: 123, size: "small"}
    assert {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new", product: payload)
           |> render_submit() =~ "has already been taken"
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-product]", "New")
    |> render_click()
  end
end
