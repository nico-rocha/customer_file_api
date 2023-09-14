defmodule CustomerFileApi.Schemas.CustomerData do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "customers" do
    field :name, :string
    field :email, :string
    field :age, :integer
    field :imported, :boolean, default: false

    timestamps()
  end

  @params [:name, :email, :age]

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(file, params) do
    file
    |> cast(params, @params)
    |> validate_required(@params)
  end
end
