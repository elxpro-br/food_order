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
end
