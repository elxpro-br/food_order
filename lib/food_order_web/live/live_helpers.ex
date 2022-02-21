defmodule FoodOrderWeb.LiveHelpers do
  use FoodOrderWeb, :live_component
  # import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  def render(assigns) do
    ~H"""
    <div class="phx-modal fade-in">
    <div class="phx-modal-content fade-in-scale">
        <form action="">
            <input type="text" placeholder="name">
            <input type="text" placeholder="description">
            <input type="text" placeholder="price">
            <input type="text" placeholder="size">
            <button type="submit">Criar Producto</button>
        </form>
    </div>
    </div>
    """
  end
end
