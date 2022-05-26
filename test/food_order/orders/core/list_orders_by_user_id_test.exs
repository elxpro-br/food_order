defmodule FoodOrder.Orders.Core.ListOrdersByUserIdTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory
  alias FoodOrder.Orders.Core.ListOrdersByUserId

  test "return order by status" do
    order = insert(:order)
    assert 1 == ListOrdersByUserId.execute(order.user_id) |> Enum.count()
  end
end
