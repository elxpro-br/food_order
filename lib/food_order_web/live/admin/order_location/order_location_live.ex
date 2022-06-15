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
end
