defmodule Trz.Factory do
  use ExMachina.Ecto, repo: Trz.Repo

  use Trz.SurvivorFactory
end
