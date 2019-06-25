defmodule BeewellyogaWeb.Router do
  use BeewellyogaWeb, :router

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

  scope "/", BeewellyogaWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/success", BeewellyogaWeb do
    pipe_through :browser

    get "/", PageController, :success
  end

  scope "/cancelled", BeewellyogaWeb do
    pipe_through :browser

    get "/", PageController, :cancelled
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeewellyogaWeb do
  #   pipe_through :api
  # end
end
