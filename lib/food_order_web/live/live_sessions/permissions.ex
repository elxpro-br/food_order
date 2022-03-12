defmodule LiveSessions.Permissions do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  alias FoodOrderWeb.Router.Helpers, as: Routes

  def on_mount(:admin, _params, %{"user_token" => user_token}, socket) do
    assign_user(socket, :admin, user_token)
  end

  defp assign_user(socket, _, nil) do
    error_login(socket, "You must be logged in")
  end

  defp assign_user(socket, :admin, user_token) do
    current_user = Accounts.get_user_by_session_token(user_token)

    if current_user.role != :ADMIN do
      error_login(socket, "You don`t have permissions to access this page")
    else
      {:cont, assign_new(socket, :current_user, fn -> current_user end)}
    end
  end

  defp error_login(socket, message) do
    socket =
      socket
      |> put_flash(:error, message)
      |> redirect(to: Routes.main_path(socket, :index))

    {:halt, socket}
  end
end
