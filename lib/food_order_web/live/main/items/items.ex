defmodule FoodOrderWeb.Main.Items do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrderWeb.Main.Items.Item

  def update(assigns, socket) do
    products = Products.list_products()
    socket = socket |> assign(assigns) |> assign(products: products)
    {:ok, socket}
  end
end
