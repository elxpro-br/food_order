defmodule FoodOrder.Orders.Core.ListOrdersByStatusTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory
  alias FoodOrder.Orders.Core.ListOrdersByStatus

  test "return order by status" do
    insert(:order)
    assert 1 == ListOrdersByStatus.execute(:NOT_STARTED) |> Enum.count()
  end
end
