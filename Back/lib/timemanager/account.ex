defmodule Timemanager.Account do
  @moduledoc """
    Functions list:
      create_token
      create_users
      delete_token
      delete_users
      get_token!
      get_token_by_user!
      get_users!
      get_user_by_email!
      get_user_by_session_token
      update_users
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo
  alias Timemanager.Account.Users
  alias Timemanager.Account.Tokens

  @doc """
    CREATE_TOKEN
    Create a token and assign it to an user.

    ## Examples

    iex> create_token(%{field: value})
      {:ok, %Token{}}

    iex> create_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_token(attrs \\ %{}) do
    %Tokens{}
    |> Tokens.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    CREATE_USERS
    Creates a users.

    ## Examples

    iex> create_users(%{field: value})
      {:ok, %Users{}}

    iex> create_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}) do
    %Users{}
    |> Users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    DELETE_TOKEN
    Delete a token.

    ## Examples
    
    iex> delete_token(tokens)
      {:ok, %Tokens{}}

    iex> delete_token(invalid_token)
      {:error, %Ecto.changeset{}}
  """
  def delete_token(%Tokens{} = token), do: Repo.delete(token)

  @doc """
    DELETE_USERS
    Deletes a users.

    ## Examples

    iex> delete_users(users)
      {:ok, %Users{}}

    iex> delete_users(users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users(%Users{} = users), do: Repo.delete(users)

  @doc """
    GET_TOKEN
    Return the token.

    ## Examples

    iex> get_token!(userid)
      %Token{}

    iex> get_token!(wrong_userid)
      (Ecto.NoResultsError)
  """
  def get_token!(token), do: Repo.get_by!(Tokens, token: token)

  @doc false
  def get_all_users(), do: Repo.all(Users)

  @doc """
    GET_USERS
    Gets a single users.

    Raises `Ecto.NoResultsError` if the Users does not exist.

    ## Examples

    iex> get_users!(id)
      %Users{}

    iex> get_users!(wrong_id)
      ** (Ecto.NoResultsError)
  """
  def get_users!(id), do: Repo.get!(Users, id)

  @doc """
    GET_USER_BY_EMAIL
    return the user that have the given email

    ## Example

    iex> get_user_by_email!(email)
      %User{}

    iex> get_user_by_email!(wrong_email)
      (Ecto.NoResultsError)
  """
  def get_user_by_username!(username), do: Repo.get_by(Users, username: username)

  @doc """
    GET_USER_BY_SESSION_TOKEN
    Return the user link to the given token.

    ## Examples

    iex> get_user_by_session_token(token)
      {:ok, %User{}}

    iex> get_user_by_session_token(wrong_token)
      {:error, error_code}
  """
  def get_user_by_session_token(token) do
    query = from u in Users, join: t in Tokens, where: t.token == ^token, where: t.user == u.id, select: u
    user = Repo.one(query)
    if user == nil do
      {:error, %Users{}}
    else
      {:ok, user}
    end
  end

  @doc """
    PROMOTE_USER
    Promote a user role.

    ## Examples
    
    iex> promote_user(users, %{field: new_role})
      {:ok, %Users{}}

    iex> promote_user(users, %{field: wrong_role})
      {:error, %Ecto.Changeset{}}
  """
  def promote_user(%Users{} = users, attrs) do
    users
    |> Users.promoteset(attrs)
    |> Repo.update()
  end

  @doc """
    UPDATE_USER
    Updates a users.

    ## Examples

    iex> update_users(users, %{field: new_value})
      {:ok, %Users{}}

    iex> update_users(users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_users(%Users{} = users, attrs) do
    users
    |> Users.updateset(attrs)
    |> Repo.update()
  end
end
