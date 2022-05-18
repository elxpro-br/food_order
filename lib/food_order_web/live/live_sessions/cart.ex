defmodule LiveSessions.Cart do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  alias FoodOrder.Carts
  # alias FoodOrderWeb.Router.Helpers, as: Routes

  def on_mount(:default, _params, session, socket) do
    socket =
      socket
      |> assign_user(session["user_token"])
      |> create_cart()

    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end

  defp create_cart(socket) do
    current_user = socket.assigns.current_user

    if current_user != nil do
      Carts.create(current_user.id)

      socket
      |> assign(cart_id: current_user.id)
    else
      socket
    end
  end
end
