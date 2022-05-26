defmodule FoodOrder.Orders.Core.GetOrderByIdAndCustomerId do
  import Ecto.Query
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo

  def execute(order_id, customer_id) do
    Order
    |> where([o], o.id == ^order_id and o.user_id == ^customer_id)
    |> Repo.one()
  end
end
