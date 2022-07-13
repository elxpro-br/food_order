defmodule FoodOrderWeb.Admin.OrderMapLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    if connected?(socket), do: Orders.subscribe_to_receive_new_orders()
    {:ok, assign(socket, orders: Orders.all(), selected_order: nil)}
  end

  def handle_event("select_order", %{"id" => id}, socket) do
    selected_order = select_order(socket.assigns.orders, id)

    socket =
      socket
      |> assign(selected_order: selected_order)
      |> push_event("highlight-marker", selected_order)

    {:noreply, socket}
  end

  def handle_event("marker-clicked", %{"orderId" => order_id}, socket) do
    selected_order = select_order(socket.assigns.orders, order_id)
    {:noreply, assign(socket, selected_order: selected_order)}
  end

  def handle_info({:new_order, order}, socket) do
    IO.inspect order
    socket =
      socket
      |> update(:orders, &[order | &1])
      |> assign(selected_order: order)
      |> push_event("add-marker", order)

    {:noreply, socket}
  end

  defp select_order(orders, order_id) do
    Enum.find(orders, &(&1.id == order_id))
  end

  defp order_color(order, selected_order) do
    cond do
      order == selected_order -> "text-green-700"
      order.status == :NOT_STARTED -> "text-gray-700"
      order.status == :RECEIVED -> "text-blue-700"
      order.status == :PREPARING -> "text-yellow-700"
      order.status == :DELIVERING -> "text-yellow-500"
      order.status == :DELIVERED -> "text-black-500"
    end
  end
end
