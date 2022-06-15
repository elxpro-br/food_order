defmodule FoodOrderWeb.Admin.OrderLocationLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    orders = Orders.all()

    socket =
      socket
      |> assign(orders: orders)
      |> assign(selected_order: nil)

    {:ok, socket}
  end

  def handle_event("load_orders", _params, socket) do
    orders = socket.assigns.orders
    {:reply, %{orders: orders}, socket}
  end

  def handle_event("marker-clicked", %{"id" => id}, socket) do
    selected_order = Enum.find(socket.assigns.orders, &(&1.id == id))
    socket = assign(socket, selected_order: selected_order)
    {:reply, %{order: selected_order}, socket}
  end

  def handle_event("select_order", %{"id" => id}, socket) do
    selected_order = Enum.find(socket.assigns.orders, &(&1.id == id))

    socket =
      socket
      |> assign(selected_order: selected_order)
      |> push_event("highlight-marker", selected_order)

    {:noreply, socket}
  end
end
