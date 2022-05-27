defmodule LiveSessions.Cart do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  alias LiveSessions.CreateCart

  def on_mount(:default, _, session, socket) do
    cart_id = get_connect_params(socket)["cart_id"]
    socket = socket |> assign_user(session["user_token"]) |> CreateCart.execute(cart_id)
    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end
end
