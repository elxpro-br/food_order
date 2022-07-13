defmodule FoodOrder.Orders.Events.NewOrder do
  alias Phoenix.PubSub
  alias FoodOrder.Repo
  @pubsub FoodOrder.PubSub
  @topic "new_order"
  def subscribe, do: PubSub.subscribe(@pubsub, @topic)

  def broadcast({:error, _} = err), do: err

  def broadcast({:ok, order} = result) do
    order = Repo.preload(order, :user)
    PubSub.broadcast(@pubsub, @topic, {:new_order, order})
    result
  end
end
