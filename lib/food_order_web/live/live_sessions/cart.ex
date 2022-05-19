defmodule LiveSessions.Cart do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  alias FoodOrder.Carts
  # alias FoodOrderWeb.Router.Helpers, as: Routes

  def on_mount(:default, _params, session, socket) do
    cart_id = get_connect_params(socket)["cart_id"]

    socket =
      socket
      |> assign_user(session["user_token"])
      |> create_cart(cart_id)

    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end

  defp create_cart(socket, cart_id) do
    current_user = socket.assigns.current_user
    cart_id = create_cart_id(current_user, cart_id)

    socket
    |> assign(cart_id: cart_id)
    |> push_event("create-cart-session-id", %{"cartId" => cart_id})
  end

  defp create_cart_id(nil, cart_id) do
    cart_id = (cart_id == nil && Ecto.UUID.generate()) || cart_id
    Carts.create(cart_id)
    cart_id
  end

  defp create_cart_id(current_user, _cart_id) do
    cart_id = current_user.id
    Carts.create(cart_id)
    cart_id
  end
end
