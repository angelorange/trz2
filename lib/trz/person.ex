defmodule Trz.Person do
  @moduledoc """
  The Person context.
  """

  import Ecto.Query, warn: false
  alias Trz.Repo

  alias Trz.Person.Survivor

  @doc """
  Returns the list of survivors.

  ## Examples

      iex> list_survivors()
      [%Survivor{}, ...]

  """
  def list_survivors do
    Repo.all(Survivor)
  end

  @doc """
  Gets a single survivor.

  Raises `Ecto.NoResultsError` if the Survivor does not exist.

  ## Examples

      iex> get_survivor!(123)
      %Survivor{}

      iex> get_survivor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_survivor!(id), do: Repo.get!(Survivor, id)

  @doc """
  Creates a survivor.

  ## Examples

      iex> create_survivor(%{field: value})
      {:ok, %Survivor{}}

      iex> create_survivor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_survivor(attrs \\ %{}) do
    %Survivor{}
    |> Survivor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a survivor.

  ## Examples

      iex> update_survivor(survivor, %{field: new_value})
      {:ok, %Survivor{}}

      iex> update_survivor(survivor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_survivor(%Survivor{} = survivor, attrs) do
    survivor
    |> Survivor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a survivor.

  ## Examples

      iex> delete_survivor(survivor)
      {:ok, %Survivor{}}

      iex> delete_survivor(survivor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_survivor(%Survivor{} = survivor) do
    Repo.delete(survivor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking survivor changes.

  ## Examples

      iex> change_survivor(survivor)
      %Ecto.Changeset{data: %Survivor{}}

  """
  def change_survivor(%Survivor{} = survivor, attrs \\ %{}) do
    Survivor.changeset(survivor, attrs)
  end

  def mark_survivor(%Survivor{} = survivor, snitch_id) do
    marked = survivor.marked_as_infected

    new_survivor =
      if survivor.id != snitch_id do
        {:ok, new_survivor} = update_survivor(survivor, %{marked_as_infected: marked + 1})
        new_survivor
      else
        survivor
      end

    cond do
      new_survivor.marked_as_infected >= 5 ->
        update_survivor(survivor ,%{is_infected: true})

      new_survivor.marked_as_infected < 5 ->
        {:ok, new_survivor}
    end
  end

  def build_report() do
    %{
      total_infecteds: (get_total_infected() / (list_survivors() |> length())) * 100,
      total_healthys: (get_total_healthys() / (list_survivors() |> length())) * 100,
      items_per_survivor: "#{get_item_per_survivor()}/#{(list_survivors() |> length())}",
      points_lost_by_death: points_lost_by_death()
    }
  end

  defp get_total_infected() do
    Survivor
    |> where([s], s.is_infected == true)
    |> Repo.all
    |> length()
  end

  defp get_total_healthys() do
    Survivor
    |> where([s], s.is_infected == false)
    |> Repo.all
    |> length()
  end

  defp get_item_per_survivor() do
    Survivor
    |> Repo.all
    |> Enum.reduce(0, fn s, _acc ->
      s.fiji_water + s.campbell_soup + s.first_aid_pouch + s.ak47
    end)
  end

  defp points_lost_by_death do
    Survivor
    |> where([s], s.is_infected == true)
    |> Repo.all
    |> Enum.reduce(0, fn s, _acc ->
      (s.fiji_water * 14) + (s.campbell_soup * 12) + (s.first_aid_pouch * 10) + (s.ak47 * 8)
    end)
  end
end
