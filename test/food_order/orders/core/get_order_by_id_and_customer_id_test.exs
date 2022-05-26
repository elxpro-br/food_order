defmodule FoodOrder.Orders.Core.GetOrderByIdAndCustomerIdTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory
  alias FoodOrder.Orders.Core.GetOrderByIdAndCustomerId

  test "return order GetOrderByIdAndCustomerId" do
    order = insert(:order)
    assert order.id == GetOrderByIdAndCustomerId.execute(order.id, order.user_id).id
  end
end
