defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.Product.{FilterByName, ProductRow, Sort, Paginate}
  alias FoodOrderWeb.Admin.Products.Form

  @impl true
  def mount(_p, _s, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    name = params["name"] || ""
    sort_by = (params["sort_by"] || "updated_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()

    sort = %{sort_by: sort_by, sort_order: sort_order}
    live_action = socket.assigns.live_action
    products = Products.list_products(name: name, sort: sort)
    assigns = [products: products, name: "", loading: false, names: []]

    options = sort

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)
      |> assign(options: options)

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    {:ok, _} = Products.delete(id)
    {:noreply, assign(socket, :products, Products.list_products())}
  end

  @impl true
  def handle_event("suggest", %{"name" => name}, socket) do
    names = Products.list_suggest_names(name)
    {:noreply, assign(socket, names: names)}
  end

  @impl true
  def handle_event("filter-by-name", %{"name" => name}, socket) do
    socket = apply_filters(socket, name)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:list_products, name}, socket) do
    sort = socket.assigns.options
    params = [name: name, sort: sort]
    {:noreply, perfom_filter(socket, params)}
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

  defp perfom_filter(socket, params) do
    params
    |> Products.list_products()
    |> return_filter_response(socket, params)
  end

  defp return_filter_response([], socket, params) do
    assigns = [loading: false, products: [], name: params[:name], options: params[:sort]]
    name = params[:name]

    socket
    |> put_flash(:info, "There is no product with \"#{name}\"")
    |> assign(assigns)
  end

  defp return_filter_response(products, socket, _params) do
    assigns = [loading: false, products: products]
    assign(socket, assigns)
  end
end
