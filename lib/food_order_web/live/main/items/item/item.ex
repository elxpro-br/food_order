defmodule FoodOrderWeb.Main.Items.Item do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts
  alias FoodOrder.Products

  def handle_event("add", _, socket) do
    update_cart(socket)

    socket =
      socket
      |> put_flash(:info, "Item added to cart")
      |> push_redirect(to: "/")

    {:noreply, socket}
  end

  defp update_cart(socket) do
    product = socket.assigns.product
    cart_id = socket.assigns.cart_id
    Carts.add(cart_id, product)
  end
end
