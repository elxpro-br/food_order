defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Main.Hero
  alias FoodOrderWeb.Main.Items

  def mount(_p, _s, socket) do
    {:ok, socket}
  end
end
