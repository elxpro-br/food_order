defmodule FoodOrderWeb.Admin.Product.SelectPerPage do
  use FoodOrderWeb, :live_component

  def handle_event("update-select-perpage", %{"per-page-select" => per_page_value}, socket) do
    to =
      Routes.admin_product_path(socket, :index,
        page: socket.assigns.options.page,
        per_page: per_page_value,
        sort_by: socket.assigns.options.sort_by,
        sort_order: socket.assigns.options.sort_order,
        name: socket.assigns.name
      )

    {:noreply, push_patch(socket, to: to)}
  end
end
