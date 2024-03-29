defmodule Trz.PersonTest do
  use Trz.DataCase

  alias Trz.Person

  describe "survivors" do
    alias Trz.Person.Survivor

    @valid_attrs %{
      age: 42,
      gender: "some gender",
      latitude: "some latitude",
      longitude: "some longitude",
      name: "some name",
      is_infected: false,
      marked_as_infected: 0}

    @update_attrs %{
      age: 43,
      gender: "some updated gender",
      latitude: "some updated latitude",
      longitude: "some updated longitude",
      name: "some updated name",
      is_infected: true,
      marked_as_infected: 4}

    @invalid_attrs %{
      age: nil,
      gender: nil,
      latitude: nil,
      longitude: nil,
      name: nil}

    def survivor_fixture(attrs \\ %{}) do
      {:ok, survivor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Person.create_survivor()

      survivor
    end

    test "list_survivors/0 returns all survivors" do
      survivor = survivor_fixture()
      assert Person.list_survivors() == [survivor]
    end

    test "get_survivor!/1 returns the survivor with given id" do
      survivor = survivor_fixture()
      assert Person.get_survivor!(survivor.id) == survivor
    end

    test "create_survivor/1 with valid data creates a survivor" do
      assert {:ok, %Survivor{} = survivor} = Person.create_survivor(@valid_attrs)
      assert survivor.age == 42
      assert survivor.gender == "some gender"
      assert survivor.latitude == "some latitude"
      assert survivor.longitude == "some longitude"
      assert survivor.name == "some name"
    end

    test "create_survivor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Person.create_survivor(@invalid_attrs)
    end

    test "update_survivor/2 with valid data updates the survivor" do
      survivor = survivor_fixture()
      assert {:ok, %Survivor{} = survivor} = Person.update_survivor(survivor, @update_attrs)
      assert survivor.age == 43
      assert survivor.gender == "some updated gender"
      assert survivor.latitude == "some updated latitude"
      assert survivor.longitude == "some updated longitude"
      assert survivor.name == "some updated name"
    end

    test "update_survivor/2 with invalid data returns error changeset" do
      survivor = survivor_fixture()
      assert {:error, %Ecto.Changeset{}} = Person.update_survivor(survivor, @invalid_attrs)
      assert survivor == Person.get_survivor!(survivor.id)
    end

    test "delete_survivor/1 deletes the survivor" do
      survivor = survivor_fixture()
      assert {:ok, %Survivor{}} = Person.delete_survivor(survivor)
      assert_raise Ecto.NoResultsError, fn -> Person.get_survivor!(survivor.id) end
    end

    test "change_survivor/1 returns a survivor changeset" do
      survivor = survivor_fixture()
      assert %Ecto.Changeset{} = Person.change_survivor(survivor)
    end
  end
end
