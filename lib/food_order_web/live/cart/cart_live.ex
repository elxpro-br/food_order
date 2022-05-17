defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  # alias __MODULE__.EmptyCart
  alias __MODULE__.CartDetail

  def mount(_p, _s, socket) do
    {:ok, socket}
  end
end
