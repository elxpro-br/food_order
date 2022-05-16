defmodule FoodOrder.Carts.Core.HandleCarts do
  alias FoodOrder.Carts.Data.Cart
  def create_carts(id), do: Cart.new(id)

  def add_new_product(cart, item) do
    new_total_price = Money.add(cart.total_price, item.price)
    new_total_items = cart.total_items + 1

    %{
      cart
      | total_qty: cart.total_qty + 1,
        items: cart.items ++ [item],
        total_price: new_total_price,
        total_items: new_total_items
    }
  end
end
