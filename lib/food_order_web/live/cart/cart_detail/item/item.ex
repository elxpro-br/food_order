defmodule FoodOrderWeb.CartLive.CartDetail.Item do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts
  alias FoodOrder.Products

  def handle_event("inc", _, socket) do
    product_id = socket.assigns.id
    cart_id = socket.assigns.cart_id
    cart = Carts.inc(cart_id, product_id)
    send(self(), {:update, cart})
    {:noreply, socket}
  end

  def handle_event("dec", _, socket) do
    product_id = socket.assigns.id
    cart_id = socket.assigns.cart_id
    cart = Carts.dec(cart_id, product_id)
    send(self(), {:update, cart})
    {:noreply, socket}
  end

  def handle_event("remove", _, socket) do
    product_id = socket.assigns.id
    cart_id = socket.assigns.cart_id
    cart = Carts.remove(cart_id, product_id)
    send(self(), {:update, cart})
    {:noreply, socket}
  end
end
