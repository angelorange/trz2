defmodule Trz.Repo.Migrations.CreateSurvivors do
  use Ecto.Migration

  def change do
    create table(:survivors) do
      add :age, :integer
      add :name, :string
      add :gender, :string
      add :latitude, :string
      add :longitude, :string
      add :is_infected, :boolean

      timestamps()
    end

  end
end
