defmodule FoodOrderWeb.Admin.OrderLive do
  use FoodOrderWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu

  def mount(_, _, socket), do: {:ok, socket}
end
