defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory

  alias FoodOrder.Carts.Core.HandleCarts
  alias FoodOrder.Carts.Data.Cart

  @start_cart %Cart{
    id: 444_444,
    items: [],
    total_items: 0,
    total_price: %Money{amount: 0, currency: :BRL},
    total_qty: 0
  }

  describe "handle carts" do
    test "should create a new cart" do
      assert @start_cart == HandleCarts.create_carts(444_444)
    end

    test "should add a new item in the cart" do
      product = insert(:product)

      cart = HandleCarts.add_new_product(@start_cart, product)

      assert 1 == cart.total_qty
      assert [product] == cart.items
      assert product.price == cart.total_price
      assert 1 == cart.total_items
    end
  end
end
