defmodule Timemanager.ClocksManagement.WorkingsTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingstime" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :user, :id
  end

  @doc false
  def changeset(workings_time, attrs) do
    workings_time
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
  end
end
