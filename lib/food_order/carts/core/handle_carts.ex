defmodule FoodOrder.Carts.Core.HandleCarts do
  alias FoodOrder.Carts.Data.Cart
  def create_carts(id), do: Cart.new(id)
end
