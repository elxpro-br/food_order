defmodule FoodOrder.Orders do
  alias FoodOrder.Orders.Core.{
    AllStatusOrders,
    CreateOrderByCart,
    GetOrderByIdAndCustomerId,
    ListOrdersByStatus,
    ListOrdersByUserId
  }

  alias FoodOrder.Orders.Events.{NewOrder, UpdateOrder}

  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
  defdelegate subscribe_admin_orders_update, to: UpdateOrder
  defdelegate subscribe_update_user_row(user_id), to: UpdateOrder
  defdelegate subscribe_update_order(order_id), to: UpdateOrder

  defdelegate all_status_orders, to: AllStatusOrders, as: :execute
  defdelegate create_order_by_cart(payload), to: CreateOrderByCart, as: :execute

  defdelegate get_order_by_id_and_customer_id(order_id, customer_id),
    to: GetOrderByIdAndCustomerId,
    as: :execute

  defdelegate list_order_by_status(status), to: ListOrdersByStatus, as: :execute
  defdelegate list_order_by_user_id(user_id), to: ListOrdersByUserId, as: :execute
end
