defmodule FoodOrderWeb.Admin.OrderMapLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    if connected?(socket), do: Orders.subscribe_to_receive_new_orders()
    {:ok, assign(socket, orders: Orders.all(), selected_order: nil)}
  end

  def handle_event("select_order", %{"id" => id}, socket) do
    socket = assign(socket, selected_order: select_order(socket.assigns.orders, id))
    {:noreply, socket}
  end

  defp select_order(orders, order_id) do
    Enum.find(orders, &(&1.id == order_id))
  end
end
