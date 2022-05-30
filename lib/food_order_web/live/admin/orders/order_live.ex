defmodule FoodOrderWeb.Admin.OrderLive do
  use FoodOrderWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu
  alias FoodOrder.Orders
  @side_menu_id "side-menu"

  def mount(_, _, socket) do
    if connected?(socket) do
      Orders.subscribe_admin_orders_update()
      Orders.subscribe_to_receive_new_orders()
    end

    {:ok, assign(socket, side_menu_id: @side_menu_id)}
  end

  def handle_info({:order_updated, %{status: new_status}, old_status}, socket) do
    send_update(Layer, id: old_status)
    send_update(Layer, id: Atom.to_string(new_status))
    send_update(SideMenu, id: @side_menu_id)
    {:noreply, socket}
  end
end
