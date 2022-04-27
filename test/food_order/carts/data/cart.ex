defmodule FoodOrder.Carts.Data.Cart do
  defstruct id: nil, items: [], total_items: 0, total_qty: 0, total_price: Money.new(0)

  def new(id), do: %__MODULE__{id: id}
end
