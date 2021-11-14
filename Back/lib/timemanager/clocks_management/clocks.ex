defmodule Timemanager.ClocksManagement.Clocks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :user, :id
    field :fill, :boolean
  end

  @doc false
  def changeset(clocks, attrs) do
    clocks
    |> cast(attrs, [:start, :user, :fill])
    |> validate_required([:start, :user, :fill])
  end

  @doc false
  def completset(clocks, attrs) do
    clocks
    |> cast(attrs, [:end, :fill])
    |> validate_required([:end, :fill])
  end
end
