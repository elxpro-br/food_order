defmodule FoodOrder.Orders.Events.UpdateOrder do
  alias Phoenix.PubSub
  @pubsub FoodOrder.PubSub
  @admin_orders_update "admin-orders-update"
  @update_user_row "update-user-row"
  @update_order "update-order"

  def subscribe_admin_orders_update, do: PubSub.subscribe(@pubsub, @admin_orders_update)

  def broadcast_admin_orders_update({:ok, order} = result, old_status) do
    PubSub.broadcast(@pubsub, @admin_orders_update, {:order_updated, order, old_status})
    result
  end

  def subscribe_update_user_row(user_id) do
    PubSub.subscribe(@pubsub, @update_user_row <> ":#{user_id}")
  end

  def broadcast_update_user_row({:ok, order} = result) do
    PubSub.broadcast(
      @pubsub,
      @update_user_row <> ":#{order.user_id}",
      {:update_order_user_row, order}
    )

    result
  end

  def subscribe_update_order(order_id) do
    PubSub.subscribe(@pubsub, @update_order <> ":#{order_id}")
  end

  def broadcast_update_order({:ok, order} = result) do
    PubSub.broadcast(@pubsub, @update_order <> ":#{order.id}", {:update_order, order})
    result
  end
end
