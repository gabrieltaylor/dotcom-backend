defmodule Dotcom.Router do
  use Dotcom.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dotcom do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/jay", MeController, :index
    get "/jay/:messenger", MeController, :show

    resources "/posts", PostController do
      post "/comment", PostController, :add_comment
    end

    resources "/users", UserController

    resources "/:permalink", PostController do
      post "/comment", PostController, :add_comment
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", Dotcom do
  #   pipe_through :api
  # end
end
