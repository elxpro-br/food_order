defmodule FoodOrderWeb.Customer.OrderLive do
  use FoodOrderWeb, :live_view

  def mount(_, _, socket) do
    {:ok, socket}
  end
end
