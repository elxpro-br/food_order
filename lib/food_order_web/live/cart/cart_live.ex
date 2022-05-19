defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias __MODULE__.CartDetail
  alias __MODULE__.EmptyCart
  alias FoodOrder.Carts

  def mount(_p, _s, socket) do
    cart_id = socket.assigns.cart_id
    cart = Carts.get(cart_id)
    {:ok, assign(socket, cart: cart)}
  end

  def handle_info({:update, cart}, socket) do
    {:noreply, assign(socket, cart: cart)}
  end
end
