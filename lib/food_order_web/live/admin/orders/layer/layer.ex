defmodule FoodOrderWeb.Admin.OrderLive.Layer do
  use FoodOrderWeb, :live_component
  alias __MODULE__.Card
  alias FoodOrder.Orders

  def update(%{id: id} = assigns, socket) do
    cards = Orders.list_order_by_status(id)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(cards: cards)}
  end

  def handle_event("dropped", %{"new_status" => new_status, "old_status" => old_status}, socket)
      when new_status == old_status do
    {:noreply, socket}
  end

  def handle_event("dropped", params, socket) do
    %{"order_id" => order_id, "old_status" => old_status, "new_status" => new_status} = params
    Orders.update_order_status(order_id, old_status, new_status)
    {:noreply, socket}
  end
end
