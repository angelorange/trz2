defmodule Trz.Repo.Migrations.CreateSurvivors do
  use Ecto.Migration

  def change do
    create table(:survivors) do
      add :age, :integer
      add :name, :string
      add :gender, :string
      add :last_location, :string

      timestamps()
    end

  end
end
