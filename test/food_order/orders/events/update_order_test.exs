defmodule FoodOrder.Orders.Events.UpdateOrderTest do
  use FoodOrder.DataCase
  alias FoodOrder.Orders.Events.UpdateOrder

  test "subscribe_admin_orders_update" do
    UpdateOrder.subscribe_admin_orders_update()
    assert {:messages, []} == Process.info(self(), :messages)

    UpdateOrder.broadcast_admin_orders_update({:ok, %{status: :PREPARING}}, :RECEIVE)

    assert {:messages, [{:order_updated, %{status: :PREPARING}, :RECEIVE}]} =
             Process.info(self(), :messages)
  end

  test "subscribe_update_user_row" do
    user_id = "123"
    UpdateOrder.subscribe_update_user_row(user_id)
    assert {:messages, []} == Process.info(self(), :messages)

    UpdateOrder.broadcast_update_user_row({:ok, %{status: :PREPARING, user_id: user_id}})

    assert {:messages,
            [
              update_order_user_row: %{
                status: :PREPARING,
                user_id: "123"
              }
            ]} = Process.info(self(), :messages)
  end

  test "subscribe_update_order" do
    id = "123"
    UpdateOrder.subscribe_update_order(id)
    assert {:messages, []} == Process.info(self(), :messages)

    UpdateOrder.broadcast_update_order({:ok, %{status: :PREPARING, id: id}})

    assert {:messages,
            [
              update_order: %{
                status: :PREPARING,
                id: "123"
              }
            ]} = Process.info(self(), :messages)
  end
end
