defmodule TrzWeb.SurvivorControllerTest do
  use TrzWeb.ConnCase

  alias Trz.Person
  alias Trz.Person.Survivor

  @create_attrs %{
    age: 42,
    gender: "some gender",
    last_location: "some last_location",
    name: "some name"
  }
  @update_attrs %{
    age: 43,
    gender: "some updated gender",
    last_location: "some updated last_location",
    name: "some updated name"
  }
  @invalid_attrs %{age: nil, gender: nil, last_location: nil, name: nil}

  def fixture(:survivor) do
    {:ok, survivor} = Person.create_survivor(@create_attrs)
    survivor
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all survivors", %{conn: conn} do
      conn = get(conn, Routes.survivor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create survivor" do
    test "renders survivor when data is valid", %{conn: conn} do
      conn = post(conn, Routes.survivor_path(conn, :create), survivor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.survivor_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 42,
               "gender" => "some gender",
               "last_location" => "some last_location",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.survivor_path(conn, :create), survivor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update survivor" do
    setup [:create_survivor]

    test "renders survivor when data is valid", %{conn: conn, survivor: %Survivor{id: id} = survivor} do
      conn = put(conn, Routes.survivor_path(conn, :update, survivor), survivor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.survivor_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 43,
               "gender" => "some updated gender",
               "last_location" => "some updated last_location",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, survivor: survivor} do
      conn = put(conn, Routes.survivor_path(conn, :update, survivor), survivor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete survivor" do
    setup [:create_survivor]

    test "deletes chosen survivor", %{conn: conn, survivor: survivor} do
      conn = delete(conn, Routes.survivor_path(conn, :delete, survivor))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.survivor_path(conn, :show, survivor))
      end
    end
  end

  defp create_survivor(_) do
    survivor = fixture(:survivor)
    %{survivor: survivor}
  end
end
