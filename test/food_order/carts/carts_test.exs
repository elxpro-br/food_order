defmodule FoodOrder.CartsTest do
  use FoodOrder.DataCase
  alias FoodOrder.Carts

  test "should create session" do
    assert :ok == Carts.create_session(4444)
  end
end
