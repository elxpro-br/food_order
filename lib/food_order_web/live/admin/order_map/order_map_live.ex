defmodule FoodOrderWeb.Admin.OrderMapLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    orders = Orders.all
    socket = assign(socket, orders: orders, selected_order: nil)
    {:ok, socket}
  end

  def handle_event("select-order", %{"id" => id}, socket) do
    selected_order = select_order(socket, id)
    {:noreply, assign(socket, selected_order: selected_order)}
  end

  defp select_order(%{assigns: %{orders: orders}}, id), do: Enum.find(orders, &(&1.id == id)).id
end
