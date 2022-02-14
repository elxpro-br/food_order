defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products

  def mount(_p, _s, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end
end
