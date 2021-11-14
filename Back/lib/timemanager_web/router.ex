defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug TimemanagerWeb.Plugs.Authenticate
  end

  pipeline :notemployee do
    plug TimemanagerWeb.Plugs.NotEmployee
  end

  pipeline :isgeneral do
    plug TimemanagerWeb.Plugs.IsGeneral
  end

  # ACCOUNT ROUTES
  scope "/api", TimemanagerWeb do
    pipe_through :api

    post "/sign_in", UsersController, :sign_in
    post "/sign_up", UsersController, :sign_up
  end
  
  # API ROUTES FOR ALL USERS
  scope "/api", TimemanagerWeb do
    pipe_through [:api, :authenticate]

    get "/users", UsersController, :show
    get "/users/:userID", UsersController, :show_user
    delete "/users", UsersController, :delete
    post "/sign_out", UsersController, :sign_out
    post "/clock", ClocksController, :create
    put "/users", UsersController, :update
  end

  # API ROUTE FOR MANAGER AND GENERAL MANAGER
  scope "/api", TimemanagerWeb do
    pipe_through [:api, :authenticate, :notemployee]

    get "/team/teammate/:teamID", TeamsController, :getteam
    delete "/team/:teamID", TeamsController, :delete
    delete "/team/teammate/:teamID/:userID", TeamsController, :removetoteam
    post "/team/create", TeamsController, :create
    post "/team/teammate/:teamID/:userID", TeamsController, :addtoteam
    post "/workingtime/create/:userID", WorkingsTimeController, :create
  end

  # API ROUTE ONLY FOR GENERAL MANAGER
  scope "/api", TimemanagerWeb do
    pipe_through [:api, :authenticate, :isgeneral]

    get "/users/all", UsersController, :index
    delete "/users/:userID", UsersController, :delete_user
    post "/users/promote/:userID", UsersController, :promote
    post "/users/:userID", UsersController, :mofify_user
  end
end
