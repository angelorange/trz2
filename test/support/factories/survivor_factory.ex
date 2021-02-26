defmodule Trz.SurvivorFactory do
  defmacro __using__(_opts) do
    quote do
      def survivor_factory do
        %Trz.Person.Survivor{
          name: Faker.Person.name,
          gender: "Feminino",
          age: :rand.uniform(100),
          is_infected: false,
          latitude: "40.35",
          longitude: "20.50",
          fiji_water: 0,
          campbell_soup: 0,
          first_aid_pouch: 0,
          ak47: 0
        }
      end
    end
  end
end
