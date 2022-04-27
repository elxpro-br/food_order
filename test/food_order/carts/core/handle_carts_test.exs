defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase
  alias FoodOrder.Carts.Core.HandleCarts
  alias FoodOrder.Carts.Data.Cart

  describe "handle carts" do
    test "should create a new cart" do
      assert "" == HandleCarts.create_carts(444_444)
    end
  end
end
