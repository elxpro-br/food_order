defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Carts
  alias __MODULE__.EmptyCart
  alias __MODULE__.CartDetail

  def mount(_p, _s, socket) do
    cart = Carts.get(socket.assigns.cart_id)
    socket = assign(socket, cart: cart)
    {:ok, socket}
  end

  def handle_info({:update, cart}, socket) do
    {:noreply, assign(socket, cart: cart)}
  end
end
