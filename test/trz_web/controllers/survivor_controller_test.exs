defmodule TrzWeb.Controllers.SurvivorControllerTest do
  use TrzWeb.ConnCase

  import Trz.Factory

  describe "create" do
    test "a survivor", %{conn: conn} do
      params = %{
        name: Faker.Person.name,
        age: 20,
        gender: "Feminino",
        latitude: "34.543666",
        longitude: "11.445465",
        fiji_water: 5,
        campbell_soup: 6,
        first_aid_pouch: 2,
        ak47: 3
      }

      conn = post(conn, Routes.survivor_path(conn, :create, params))

      assert expected = json_response(conn, 201)["data"]
      assert expected["gender"] == params.gender
      assert expected["age"] == params.age
      assert expected["is_infected"] == false
      assert expected["fiji_water"] == params.fiji_water
      assert expected["campbell_soup"] == params.campbell_soup
      assert expected["first_aid_pouch"] == params.first_aid_pouch
      assert expected["ak47"] == params.ak47
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
      survivor = insert(:survivor, %{is_infected: false})

      params = %{snitch_id: survivor.id}

      conn = put(conn, Routes.survivor_path(conn, :flag_survivor, survivor.id, params))

      assert expected = json_response(conn, 200)["data"]
      assert expected["is_infected"] == false
      assert expected["marked_as_infected"] == 0
    end
  end

  describe "report" do
    test "of everything", %{conn: conn} do
      _survivor = insert(:survivor, %{is_infected: true, fiji_water: 2, campbell_soup: 3, first_aid_pouch: 0, ak47: 2})
      _survivor_two = insert(:survivor, %{is_infected: false, fiji_water: 0, campbell_soup: 0, first_aid_pouch: 1, ak47: 0})
      _survivor_three = insert(:survivor, %{is_infected: true, fiji_water: 0, campbell_soup: 0, first_aid_pouch: 0, ak47: 2})
      _survivor_four = insert(:survivor, %{is_infected: true, fiji_water: 2, campbell_soup: 3, first_aid_pouch: 1, ak47: 0})

      total_items = %{
        "fiji_water" => "8/4",
        "campbell_soup" => "12/4",
        "first_aid_pouch" => "4/4",
        "ak47" => "8/4"
      }

      conn = get(conn, Routes.survivor_path(conn, :reports))

      assert expected = json_response(conn, 200)["data"] |> IO.inspect
      assert expected["total_infecteds"] == 75
      assert expected["total_healthys"] == 25
      assert expected["points_lost_by_death"] == 1
      assert expected["items_per_survivor"] == total_items
    end
  end

  describe "trade" do
    test "through survivors", %{conn: conn} do
      survivor_one = insert(:survivor, %{is_infected: false, fiji_water: 5, first_aid_pouch: 5})
      survivor_two = insert(:survivor, %{is_infected: false, campbell_soup: 6, ak47: 6})

      params = %{survivor_one: survivor_one.id, survivor_two: survivor_two.id}

      conn = post(conn, Routes.survivor_path(conn, :trade))

      assert expected = json_response(conn, 200)["data"]
      assert expected["survivor_one"] == params.survivor_one
      assert expected["survivor_two"] == params.survivor_two
      assert expected["trade status"] == "succesfully trade"
    end
  end
end
