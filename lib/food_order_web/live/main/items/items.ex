defmodule FoodOrderWeb.Main.Items do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrderWeb.Main.Items.Item

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign(page: 1, per_page: 8) |> assign_products()
    {:ok, socket}
  end

  def handle_event("load-more", _, socket) do
    socket = socket |> update(:page, &(&1 + 1)) |> assign_products()
    {:noreply, socket}
  end

  defp assign_products(socket) do
    page = socket.assigns.page
    per_page = socket.assigns.per_page
    paginage = [{:paginate, %{page: page, per_page: per_page}}]
    products = Products.list_products(paginage)
    assign(socket, products: products)
  end
end
