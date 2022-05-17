defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias __MODULE__.EmptyCart

  def mount(_p, _s, socket) do
    {:ok, socket}
  end
end
