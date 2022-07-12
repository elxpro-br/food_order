defmodule FoodOrder.Orders.Data.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodOrder.Accounts.User
  alias FoodOrder.Orders.Data.Item

  defimpl Jason.Encoder, for: Money do
    def encode(value, opts) do
      Jason.Encode.string(Money.to_string(value), opts)
    end
  end

  @status_values ~w/NOT_STARTED RECEIVED PREPARING DELIVERING DELIVERED/a
  @field ~w/status latitude longitude/a
  @required_field ~w/total_price total_quantity user_id address phone_number/a
  @derive {Jason.Encoder, only: @field ++ @required_field ++ [:user]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :total_quantity, :integer
    field :address, :string
    field :phone_number, :string
    field :total_price, Money.Ecto.Amount.Type
    field :status, Ecto.Enum, values: @status_values, default: :NOT_STARTED
    field :latitude, :float
    field :longitude, :float

    belongs_to :user, User
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @field ++ @required_field)
    |> validate_required(@required_field)
    |> validate_number(:total_quantity, greater_than: 0)
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
