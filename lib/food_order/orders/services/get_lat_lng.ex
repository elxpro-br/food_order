defmodule FoodOrder.Orders.Services.GetLatLng do
  @client [
    {Tesla.Middleware.BaseUrl, "http://api.positionstack.com/v1"},
    Tesla.Middleware.JSON
  ]

  def execute(query) do
    access_key = "c3a90d72173d15d905ec987a7391ddab"

    query = [
      access_key: access_key,
      query: query
    ]

    @client
    |> Tesla.client()
    |> Tesla.get("/forward", query: query)
    |> result
  end

  defp result({:error, _}), do: %{latitude: -22.734297, longitude: -47.334784}

  defp result({:ok, %{body: %{"error" => _}}}), do: %{latitude: -22.734297, longitude: -47.334784}

  defp result({:ok, %{body: %{"data" => [first_address | _]}}}) do
    %{latitude: first_address["latitude"], longitude: first_address["longitude"]}
  end
end
