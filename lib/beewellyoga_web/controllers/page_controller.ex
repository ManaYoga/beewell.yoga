defmodule BeewellyogaWeb.PageController do
  use BeewellyogaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", site_domain: "beewell.yoga", stripe_publishable_key: "", stripe_skus: "")
  end

  def success(conn, _params) do
    render(conn, "success.html", site_domain: "beewell.yoga")
  end

  def canceled(conn, _params) do
    render(conn, "canceled.html", site_domain: "beewell.yoga")
  end
end
