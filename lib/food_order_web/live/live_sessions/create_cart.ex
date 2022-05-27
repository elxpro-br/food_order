defmodule LiveSessions.CreateCart do
  import Phoenix.LiveView
  alias FoodOrder.Carts

  def execute(socket, cart_id) do
    current_user = socket.assigns.current_user

    cart_id = build_cart_id(current_user, cart_id)

    socket
    |> assign(cart_id: cart_id)
    |> push_event("create-cart-session-id", %{"cartId" => cart_id})
  end

  defp build_cart_id(nil, nil) do
    cart_id = Ecto.UUID.generate()
    Carts.create(cart_id)
    cart_id
  end

  defp build_cart_id(nil, cart_id) do
    Carts.create(cart_id)
    cart_id
  end

  defp build_cart_id(%{id: cart_id}, _cart_id) do
    Carts.create(cart_id)
    cart_id
  end
end
