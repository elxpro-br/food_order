defmodule FoodOrder.Orders.Core.CreateOrderByCart do
  alias FoodOrder.Carts
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Orders.Events.NewOrder
  alias FoodOrder.Orders.Services.GetLatLng
  alias FoodOrder.Repo

  def execute(%{"current_user" => current_user} = payload) do
    current_user
    |> Carts.get()
    |> convert_session_to_payload_item
    |> create_order_payload(payload)
    |> include_lat_lng
    |> build_changeset
    |> Repo.insert()
    |> NewOrder.broadcast()
    |> remove_cache()
  end

  defp include_lat_lng(%{address: address} = payload) do
    lat_lng = GetLatLng.execute(address)
    Map.merge(payload, lat_lng)
  end

  defp build_changeset(payload) do
    Order.changeset(%Order{}, payload)
  end

  defp convert_session_to_payload_item(%{items: items} = cart) do
    payload_items = Enum.map(items, &%{quantity: &1.qty, product_id: &1.item.id})
    {cart, payload_items}
  end

  defp create_order_payload({cart, items}, payload) do
    %{
      phone_number: payload["phone_number"],
      address: payload["address"],
      user_id: payload["current_user"],
      items: items,
      total_quantity: cart.total_qty,
      total_price: cart.total_price
    }
  end

  defp remove_cache({:error, _} = err), do: err

  defp remove_cache({:ok, order} = result) do
    Carts.delete_cart(order.user_id)
    result
  end
end
