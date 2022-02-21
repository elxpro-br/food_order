defmodule FoodOrderWeb.Admin.Products.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  def update(assigns, socket) do
    changeset = Products.change_product()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> assign(product: %Product{})}
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    case Products.create_product(product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product has created")
         |> push_redirect(to: "/admin/products")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
