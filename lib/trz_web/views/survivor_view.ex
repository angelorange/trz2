defmodule TrzWeb.SurvivorView do
  use TrzWeb, :view
  alias TrzWeb.SurvivorView

  def render("index.json", %{survivors: survivors}) do
    %{data: render_many(survivors, SurvivorView, "survivor.json")}
  end

  def render("show.json", %{survivor: survivor}) do
    %{data: render_one(survivor, SurvivorView, "survivor.json")}
  end

  def render("survivor.json", %{survivor: survivor}) do
    %{id: survivor.id,
      age: survivor.age,
      name: survivor.name,
      gender: survivor.gender,
      latitude: survivor.latitude,
      longitude: survivor.longitude,
      is_infected: survivor.is_infected}
  end
end
