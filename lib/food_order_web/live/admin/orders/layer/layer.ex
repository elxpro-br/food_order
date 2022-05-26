defmodule FoodOrderWeb.Admin.OrderLive.Layer do
  use FoodOrderWeb, :live_component
  alias __MODULE__.Card

  @status [:NOT_STARTED, :DELIVERED]

  def update(assigns, socket) do
    cards = [
      %{
        id: Ecto.UUID.generate(),
        updated_at: DateTime.utc_now(),
        status: @status |> Enum.shuffle() |> hd,
        user: %{
          email: "adm@elxpro.com"
        },
        total_price: Money.new(10_000),
        total_quantity: 2,
        items: [
          %{
            id: Ecto.UUID.generate(),
            quantity: 10,
            product: %{
              name: "abobora",
              price: Money.new(200)
            }
          },
          %{
            id: Ecto.UUID.generate(),
            quantity: 10,
            product: %{
              name: "abobora",
              price: Money.new(200)
            }
          }
        ]
      },
      %{
        id: Ecto.UUID.generate(),
        updated_at: DateTime.utc_now(),
        status: @status |> Enum.shuffle() |> hd,
        user: %{
          email: "adm@elxpro.com"
        },
        total_price: Money.new(10_000),
        total_quantity: 2,
        items: [
          %{
            id: Ecto.UUID.generate(),
            quantity: 10,
            product: %{
              name: "abobora",
              price: Money.new(200)
            }
          },
          %{
            id: Ecto.UUID.generate(),
            quantity: 10,
            product: %{
              name: "abobora",
              price: Money.new(200)
            }
          }
        ]
      }
    ]

    {:ok,
     socket
     |> assign(assigns)
     |> assign(cards: cards)}
  end
end
