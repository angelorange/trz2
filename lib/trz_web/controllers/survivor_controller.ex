defmodule TrzWeb.SurvivorController do
  use TrzWeb, :controller

  alias Trz.Person
  alias Trz.Person.Survivor

  action_fallback TrzWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Survivor{} = survivor} <- Person.create_survivor(params) do
      conn
      |> put_status(:created)
      |> render("show.json", survivor: survivor)
    end
  end

  def update_location(conn, %{"id" => id, "last_location" => ll_params}) do
    with survivor <- Trz.Person.get_survivor!(id),
      {:ok, %Survivor{} = new_survivor} <- Person.update_survivor(survivor, sanitizer(ll_params)) do
      conn
      |> put_status(:ok)
      |> render("show.json", survivor: new_survivor)
    end
  end

  def flag_survivor(conn, %{"id" => id, "snitch_id" => snitch_id}) do
    with survivor <- Trz.Person.get_survivor!(id),
      snitch <- Trz.Person.get_survivor!(snitch_id),
      {:ok, %Survivor{} = flagged_survivor} <- Person.mark_survivor(survivor, snitch.id) do
      conn
      |> put_status(:ok)
      |> render("show.json", survivor: flagged_survivor)
    end
  end

  def reports(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("report.json", report: Person.build_report())
  end

  def trade(conn, params) do
    with s_one <- Trz.Person.get_survivor!(params["survivor_one_id"]),
      s_two <- Trz.Person.get_survivor!(params["survivor_two_id"]) do

      ["algo"]

      conn
      |> put_status(:ok)
      |> json(%{data: %{trade_status: "succesfully trade", survivor_one_id: s_one.id, survivor_two_id: s_two.id}})
    end
  end

  defp sanitizer(ll_params) do
    %{latitude: ll_params["latitude"], longitude: ll_params["longitude"]}
  end
end
