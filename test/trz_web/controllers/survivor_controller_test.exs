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
        longitude: "11.445465"
      }

      conn = post(conn, Routes.survivor_path(conn, :create, params))

      assert expected = json_response(conn, 201)["data"]
      assert expected["gender"] == params.gender
      assert expected["age"] == params.age
      assert expected["is_infected"] == false
      assert expected["marked_as_infected"] == 0
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

  describe "flag" do
    test "a survivor that already been marked 4 time", %{conn: conn} do #TODO
      survivor = insert(:survivor, %{is_infected: false, marked_as_infected: 4})
      snitch = insert(:survivor)

      params = %{snitch_id: snitch.id}

      conn = put(conn, Routes.survivor_path(conn, :flag_survivor, survivor.id, params))

      assert expected = json_response(conn, 200)["data"]
      assert expected["is_infected"] == true
    end

    test "marked survivor for the first time", %{conn: conn} do
      survivor = insert(:survivor, %{is_infected: false})
      snitch = insert(:survivor)

      params = %{snitch_id: snitch.id}

      conn = put(conn, Routes.survivor_path(conn, :flag_survivor, survivor.id, params))

      assert expected = json_response(conn, 200)["data"]
      assert expected["is_infected"] == false
      assert expected["marked_as_infected"] == 1
    end

    test "can't mark himself", %{conn: conn} do

    end
  end
end
