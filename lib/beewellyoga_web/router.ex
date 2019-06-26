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

  scope "/canceled", BeewellyogaWeb do
    pipe_through :browser

    get "/", PageController, :canceled
  end

  scope "/checkout", BeewellyogaWeb do
    pipe_through :browser

    get "/", PageController, :checkout
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeewellyogaWeb do
  #   pipe_through :api
  # end
end
