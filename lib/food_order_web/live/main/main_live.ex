defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view

  def mount(_assigns, _session, socket) do
    {:ok, socket |> assign(name: "Gustavo", age: "29")}
  end
end
