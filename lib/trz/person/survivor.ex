defmodule Trz.Person.Survivor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survivors" do
    field :age, :integer
    field :gender, :string
    field :last_location, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(survivor, attrs) do
    survivor
    |> cast(attrs, [:age, :name, :gender, :last_location])
    |> validate_required([:age, :name, :gender, :last_location])
  end
end
