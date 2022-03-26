defmodule FoodOrderWeb.Admin.Product.Paginate do
  use FoodOrderWeb, :live_component

  def page_link(
        %{name: name, options: options, page: page, socket: socket, text: text, data_id: data_id} =
          assigns
      ) do
    ~H"""
      <%= live_patch(text, to: Routes.admin_product_path(socket, :index,
              page: page,
              per_page: options.per_page,
              sort_by: options.sort_by,
              sort_order: options.sort_order,
              name: name
              ), "data-role": "paginate", "data-id": data_id) %>
    """
  end

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
