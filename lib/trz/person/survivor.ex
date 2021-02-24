defmodule Trz.Person.Survivor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survivors" do
    field :age, :integer
    field :gender, :string
    field :latitude, :string
    field :longitude, :string
    field :name, :string
    field :is_infected, :boolean, default: false
    field :marked_as_infected, :integer, default: 0

    timestamps()
  end

  @required_params [:age, :name, :gender, :latitude, :longitude, :is_infected]
  @optional_params [:is_infected, :marked_as_infected]
  @doc false
  def changeset(survivor, attrs) do
    survivor
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end
end
