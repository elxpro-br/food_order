defmodule FoodOrder.Repo do
  use Ecto.Repo,
    otp_app: :food_order,
    adapter: Ecto.Adapters.Postgres
end
