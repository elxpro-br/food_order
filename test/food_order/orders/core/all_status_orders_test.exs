defmodule FoodOrder.Orders.Core.AllStatusOrdersTest do
  use FoodOrder.DataCase
  alias FoodOrder.Orders.Core.AllStatusOrders

  test "return qty per status" do
    assert %AllStatusOrders{
             all: 0,
             delivered: 0,
             delivering: 0,
             not_started: 0,
             preparing: 0,
             received: 0
           } == AllStatusOrders.execute()
  end
end
