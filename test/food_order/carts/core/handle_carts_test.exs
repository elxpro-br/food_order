defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory

  import FoodOrder.Carts.Core.HandleCarts
  alias FoodOrder.Carts.Data.Cart

  @start_cart %Cart{
    id: 444_444,
    items: [],
    total_price: %Money{amount: 0, currency: :BRL},
    total_qty: 0
  }

  describe "handle carts" do
    test "should create a new cart" do
      assert @start_cart == create_carts(444_444)
    end

    test "should add a new item in the cart" do
      product = insert(:product)

      cart = add_new_product(@start_cart, product)

      assert 1 == cart.total_qty
      assert [%{item: product, qty: 1}] == cart.items
      assert product.price == cart.total_price
    end

    test "should add the same item twice" do
      product = insert(:product)

      cart =
        @start_cart
        |> add_new_product(product)
        |> add_new_product(product)

      assert 2 == cart.total_qty
      assert Money.add(product.price, product.price) == cart.total_price
      assert [%{item: product, qty: 2}] == cart.items
    end

    test "should remove an item" do
      product = insert(:product)
      product_2 = insert(:product)

      cart =
        @start_cart
        |> add_new_product(product)
        |> add_new_product(product)
        |> add_new_product(product_2)

      assert 3 == cart.total_qty

      assert Money.add(product.price, product.price) |> Money.add(product_2.price) ==
               cart.total_price

      assert [%{item: product, qty: 2}, %{item: product_2, qty: 1}] == cart.items

      cart = remove(cart, product.id)

      assert 1 == cart.total_qty

      assert product_2.price ==
               cart.total_price

      assert [%{item: product_2, qty: 1}] == cart.items
    end
  end
end