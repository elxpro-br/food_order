defmodule FoodOrderWeb.Admin.OrderMapLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    if connected?(socket), do: Orders.subscribe_to_receive_new_orders()
    assigns = [
      orders: Orders.all(),
      selected_order: nil
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("select_order", %{"id" => id}, socket) do
    orders = socket.assigns.orders
    socket = assign(socket, selected_order: select_order(orders, id))
    {:noreply, socket}
  end

  defp select_order(orders, id) do
    Enum.find(orders, &(&1.id == id))
  end
end
