defmodule FoodOrder.Carts.Core.HandleCarts do
  alias FoodOrder.Carts.Data.Cart
  def create_carts(id), do: Cart.new(id)

  def add(cart, item) do
    new_total_price = Money.add(cart.total_price, item.price)
    items = cart.items
    new_items = new_item(items, item)

    %{
      cart
      | total_qty: cart.total_qty + 1,
        items: new_items,
        total_price: new_total_price
    }
  end

  defp new_item(items, item) do
    is_there_item_id? = Enum.find(items, &(&1.item.id == item.id))

    if is_there_item_id? == nil do
      items ++ [%{item: item, qty: 1}]
    else
      items
      |> Map.new(fn item -> {item.item.id, item} end)
      |> Map.update!(item.id, &%{&1 | qty: &1.qty + 1})
      |> Map.values()
    end
  end

  def remove(cart, item_id) do
    {items, item_removed} = Enum.reduce(cart.items, {[], nil}, &remove_item(&1, &2, item_id))
    total_price_to_remove_from_item = Money.multiply(item_removed.item.price, item_removed.qty)
    total_price = Money.subtract(cart.total_price, total_price_to_remove_from_item)
    %{cart | items: items, total_qty: cart.total_qty - item_removed.qty, total_price: total_price}
  end

  defp remove_item(item, acc, item_id) do
    if item.item.id == item_id do
      {list, _item_acc} = acc
      {list, item}
    else
      {list, item_acc} = acc
      {[item] ++ list, item_acc}
    end
  end

  def inc(%{items: items} = cart, item_id) do
    {items_updated, product} =
      Enum.reduce(items, {[], nil}, fn product_info, acc ->
        if product_info.item.id == item_id do
          {list, _product} = acc
          updated_item = %{product_info | qty: product_info.qty + 1}
          item_updated = [updated_item]
          {list ++ item_updated, updated_item}
        else
          {list, item_updated} = acc
          {[product_info] ++ list, item_updated}
        end
      end)

    total_price = Money.add(cart.total_price, product.item.price)
    %{cart | items: items_updated, total_qty: cart.total_qty + 1, total_price: total_price}
  end
end
