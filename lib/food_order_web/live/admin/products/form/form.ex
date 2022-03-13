defmodule FoodOrderWeb.Admin.Products.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products

  @upload_configs [accept: ~w/.png .jpeg .jpg/, max_entries: 1, max_file_size: 10_000_000]

  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> allow_upload(:photo, @upload_configs)
     |> assign(product: product)}
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    action = socket.assigns.action
    save(socket, action, product_params)
  end

  def handle_event("cancel", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photo, ref)}
  end

  def save(socket, :edit, product_params) do
    case Products.update_product(socket.assigns.product, product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated!")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save(socket, :new, product_params) do
    case Products.create_product(product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product has created")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
