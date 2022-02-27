defmodule FoodOrderWeb.Admin.ProductLive.Show do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products

  def mount(_p, _s, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, _uri, socket) do
    product = Products.get!(id)

    {:noreply,
     socket
     |> assign(page_title: "Show!!!")
     |> assign(product: product)}
  end
end
