defmodule ArtikelWeb.Router do
  use ArtikelWeb, :router

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

  scope "/", ArtikelWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/articles", ArtikelController, :list_articles
    get "/article/:article_id", ArtikelController, :show_article
    get "/search/:keyword", ArtikelController, :search_article
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArtikelWeb do
  #   pipe_through :api
  # end
end
