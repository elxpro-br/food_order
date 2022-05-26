defmodule FoodOrder.Orders.Core.CreateOrderByCart do
  alias FoodOrder.Carts
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Orders.Events.NewOrder
  alias FoodOrder.Repo

  def execute(%{"current_user" => current_user} = payload) do
    current_user
    |> Carts.get()
    |> convert_session_to_payload_item
    |> create_order_payload(payload)
    |> Repo.insert()
    |> NewOrder.broadcast()
    |> remove_cache()
  end

  defp convert_session_to_payload_item(%{items: items} = cart) do
    payload_items = Enum.map(items, &%{quantity: &1.qty, product_id: &1.item.id})
    {cart, payload_items}
  end

  defp create_order_payload({cart, items}, payload) do
    changeset = %{
      phone_number: payload["phone_number"],
      address: payload["address"],
      user_id: payload["current_user"],
      items: items,
      total_quantity: cart.total_qty,
      total_price: cart.total_price
    }

    Order.changeset(%Order{}, changeset)
  end

  defp remove_cache({:error, _} = err), do: err

  defp remove_cache({:ok, order} = result) do
    Carts.delete_cart(order.user_id)
    result
  end
end
