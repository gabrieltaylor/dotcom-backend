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

  pipeline :public_pages do
    plug :put_layout, {Dotcom.LayoutView, :public}
  end

  # Admin Facing Pages
  scope "/admin", Dotcom.Admin, as: :admin do
    pipe_through :browser

    # CRUD for Blog Posts and Associated Comments
    resources "/posts", PostController do
      post "/comment", PostController, :add_comment
    end

  end

  # Public Pages
  scope "/", Dotcom do
    pipe_through [ :browser, :public_pages ]

    get "/", PostController, :home

    resources "/:permalink", PostController, only: [:index, :show] do
      post "/comment", PostController, :add_comment
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", Dotcom do
  #   pipe_through :api
  # end

end
