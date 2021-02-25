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
      add :marked_as_infected, :integer
      add :fiji_water, :integer
      add :campbell_soup, :integer
      add :first_aid_pouch, :integer
      add :ak47, :integer

      timestamps()
    end

  end
end
