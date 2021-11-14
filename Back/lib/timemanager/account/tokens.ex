defmodule Timemanager.Account.Tokens do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :created_at, :date
    field :token, :string
    field :user, :id
  end

  @doc false
  def changeset(tokens, attrs) do
    tokens
    |> cast(attrs, [:token, :created_at, :user])
    |> validate_required([:token, :created_at, :user])
  end
end
