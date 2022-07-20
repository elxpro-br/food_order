defmodule FoodOrder.Orders.Services.GetLatLng do
  @client [
    {Tesla.Middleware.BaseUrl, "http://api.positionstack.com/v1"},
    Tesla.Middleware.JSON
  ]

  def execute(query) do
    query = [
      access_key: Application.get_env(:food_order, :position_stack_key),
      query: query
    ]

    @client
    |> Tesla.client()
    |> Tesla.get("/forward", query: query)
    |> result
  end

  defp result({:ok, %{body: %{"data" => [first_address | _]}}}) do
    %{lat: first_address["latitude"], lng: first_address["longitude"]}
  end
end
