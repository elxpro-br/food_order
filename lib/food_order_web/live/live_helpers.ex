defmodule FoodOrderWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  def modal(assigns) do
    ~H"""
    <div class="phx-modal fade-in shadow-md rounded px-8 pt-6 pb-8 mb-4" data-role="modal">
      <div class="phx-modal-content fade-in-scale">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
