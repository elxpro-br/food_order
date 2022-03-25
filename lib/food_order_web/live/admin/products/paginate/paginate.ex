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
end
