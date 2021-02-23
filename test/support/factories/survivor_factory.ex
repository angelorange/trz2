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
          longitude: "20.50"
        }
      end
    end
  end
end
