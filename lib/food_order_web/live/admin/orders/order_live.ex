defmodule FoodOrderWeb.Admin.OrderLive do
  use FoodOrderWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    if connected?(socket) do
      Orders.subscribe_admin_orders_update()
      Orders.subscribe_to_receive_new_orders()
    end
    {:ok, socket}
  end
end
