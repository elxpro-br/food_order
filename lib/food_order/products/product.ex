defmodule FoodOrder.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w/description/a
  @required_fiels ~w/name price size/a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :description, :string
    field :price, Money.Ecto.Amount.Type
    field :size, :string

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields ++ @required_fiels)
    |> validate_required(@required_fiels)
    |> unique_constraint(:name, name: :products_name_index)
  end
end
