defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view

  def mount(_p, _s, socket) do
    {:ok, socket}
  end
end
