defmodule Timemanager.Account.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :role, Ecto.Enum, values: [:employee, :manager, :general]
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def add_password(changeset, password) do
    changeset
    |> change(Bcrypt.add_hash(password))
  end

  @doc false
  def validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]+$/)
    |> unique_constraint([:email], name: "unique_email")
  end

  @doc false
  def changeset(user, attrs) do
    # IO.puts(attrs)
    user
    |> cast(attrs, [:username, :email, :role])
    |> unique_constraint([:username], name: "unique_username")
    |> validate_email()
    |> add_password(attrs.password)
    |> validate_required([:username, :email, :role])
  end

  @doc false
  def updateset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> unique_constraint([:username], name: "unique_username")
    |> validate_email()
    |> validate_required([:username, :email, :role])
  end

  @doc false
  def promoteset(user, attrs) do
    user
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end
