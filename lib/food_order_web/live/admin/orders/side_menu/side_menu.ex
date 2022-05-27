defmodule FoodOrderWeb.Admin.OrderLive.SideMenu do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders

  def update(assigns, socket) do
    order_status = Orders.all_status_orders()
    socket = socket |> assign(assigns) |> assign(order_status: order_status)
    {:ok, socket}
  end
end
