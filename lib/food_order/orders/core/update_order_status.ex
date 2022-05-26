defmodule FoodOrder.Orders.Core.UpdateOrderStatus do
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Orders.Events.UpdateOrder
  alias FoodOrder.Repo

  def execute(order_id, old_status, new_status) do
    Order
    |> Repo.get(order_id)
    |> Order.changeset(%{status: new_status})
    |> Repo.update()
    |> UpdateOrder.broadcast_admin_orders_update(old_status)
    |> UpdateOrder.broadcast_update_order()
    |> UpdateOrder.broadcast_update_user_row()
  end
end
