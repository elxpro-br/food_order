defmodule FoodOrderWeb.Admin.Product.Sort do
  use FoodOrderWeb, :live_component

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_color(assigns)
      |> assign_sort_order(assigns)

    {:ok, socket}
  end

  defp assign_color(socket, %{sort_by: sort_by, options: %{sort_by: sort_by_options}}) do

    if sort_by == sort_by_options do
      assign(socket, color: "#ff761a")
    else
      assign(socket, color: "#ccc")
    end
  end

  defp assign_sort_order(socket, %{options: %{sort_order: sort_order}}) do
    if sort_order == :desc do
      socket
      |> assign(icon: "sort_desc.html")
      |> assign(sort_order: :asc)
    else
      socket
      |> assign(icon: "sort_asc.html")
      |> assign(sort_order: :desc)
    end
  end
end
