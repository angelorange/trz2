defmodule TrzWeb.Controllers.SurvivorControllerTest do
  use TrzWeb.ConnCase

  alias Trz.Person

  import Trz.Factory

  describe "create" do
    test "a survivor", %{conn: conn} do
      params = %{
        name: Faker.Person.name,
        age: 20,
        gender: "Feminino",
        latitude: "34.543666",
        longitude: "11.445465",
        is_infected: false
      }

      conn = post(conn, Routes.survivor_path(conn, :create, params))

      assert expected = json_response(conn, 201)["data"]
      assert expected["gender"] == params.gender
      assert expected["age"] == params.age
      assert expected["is_infected"] == params.is_infected
    end
  end

  describe "update" do
    test "a survivor location", %{conn: conn} do
      survivor = insert(:survivor, %{latitude: "34.543666", longitude: "11.445465"})

      params = %{last_location: %{latitude: "11.44", longitude: "22.55"}}

      conn = put(conn, Routes.survivor_path(conn, :update_location, survivor.id, params))

      assert expected = json_response(conn, 200)["data"]
      assert expected["latitude"] == "11.44"
      assert expected["longitude"] == "22.55"
    end
  end
end
