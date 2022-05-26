defmodule FoodOrder.Carts do
  @cart_name :cart_session
  def create(cart_id), do: GenServer.cast(@cart_name, {:create, cart_id})
  def add(cart_id, product), do: GenServer.cast(@cart_name, {:add, cart_id, product})
  def inc(cart_id, product_id), do: GenServer.call(@cart_name, {:inc, cart_id, product_id})
  def dec(cart_id, product_id), do: GenServer.call(@cart_name, {:dec, cart_id, product_id})

  def remove(cart_id, product_id),
    do: GenServer.call(@cart_name, {:remove, cart_id, product_id})

  def get(cart_id), do: GenServer.call(@cart_name, {:get, cart_id})

  def delete_cart(cart_id), do: GenServer.cast(@cart_name, {:delete_cart, cart_id})
end
