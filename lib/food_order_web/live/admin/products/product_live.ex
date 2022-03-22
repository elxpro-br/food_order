defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.Product.FilterByName
  alias FoodOrderWeb.Admin.Product.ProductRow
  alias FoodOrderWeb.Admin.Products.Form

  @impl true
  def mount(_p, _s, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    live_action = socket.assigns.live_action
    products = Products.list_products()
    assigns = [products: products, name: "", loading: false]

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    {:ok, _} = Products.delete(id)
    {:noreply, assign(socket, :products, Products.list_products())}
  end

  @impl true
  def handle_event("filter-by-name", %{"name" => name}, socket) do
    socket = apply_filters(socket, name)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:list_products, name}, socket) do
    {:noreply, perfom_filter(socket, name)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Create new Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get!(id)

    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, product)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "List Products")
    |> assign(:product, nil)
  end

  defp apply_filters(socket, name) do
    assigns = [products: [], name: name, loading: true]
    send(self(), {:list_products, name})
    assign(socket, assigns)
  end

  defp perfom_filter(socket, name) do
    name
    |> Products.list_products()
    |> return_filter_response(socket, name)
  end

  defp return_filter_response([], socket, name) do
    assigns = [loading: false, products: []]

    socket
    |> put_flash(:info, "There is no product with \"#{name}\"")
    |> assign(assigns)
  end

  defp return_filter_response(products, socket, _name) do
    assigns = [loading: false, products: products]
    assign(socket, assigns)
  end
end
