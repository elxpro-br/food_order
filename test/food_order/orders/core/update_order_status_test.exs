defmodule FoodOrder.Orders.Core.UpdateOrderStatusTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory
  alias FoodOrder.Orders.Core.UpdateOrderStatus

  test "return order by status" do
    order = insert(:order)
    assert {:ok, result} = UpdateOrderStatus.execute(order.id, order.status, :DELIVERED)
    refute order.status == result.status
  end
end
