defmodule Trz.Person.Survivor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survivors" do
    field :age, :integer
    field :gender, :string
    field :latitude, :string
    field :longitude, :string
    field :name, :string
    field :is_infected, :boolean

    timestamps()
  end

  @required_params [:age, :name, :gender, :latitude, :longitude, :is_infected]
  @doc false
  def changeset(survivor, attrs) do
    survivor
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
