defmodule FoodOrderWeb.Customer.OrderLive do
  use FoodOrderWeb, :live_view
  alias __MODULE__.OrderRow
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    current_user = socket.assigns.current_user

    if connected?(socket) do
      Orders.subscribe_update_user_row(current_user.id)
    end

    orders = Orders.list_order_by_user_id(current_user.id)
    {:ok, assign(socket, orders: orders)}
  end
end
