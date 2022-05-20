defmodule FoodOrderWeb.CartLive.EmptyCartTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load empty page", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))
    assert has_element?(view, "[data-role=head-empty-cart]", "You Cart is Empty!!!")

    assert has_element?(
             view,
             "[data-role=description-tip]",
             "You probably haven`t ordered a food yet."
           )

    assert has_element?(
             view,
             "[data-role=description-tip]",
             "To order an good, go to the main page."
           )

    assert has_element?(view, "[data-role=go-main-page]", "Go back")
  end

  test "should go back to main page", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))

    {:ok, view, _html} =
      view
      |> element("[data-role=go-main-page]", "Go back")
      |> render_click()
      |> follow_redirect(conn, Routes.main_path(conn, :index))

    assert has_element?(view, "[data-id=recomendation]", "Make your order")
  end
end
