defmodule BeewellyogaWeb.PageController do
  use BeewellyogaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", site_domain: "beewell.yoga", stripe_publishable_key: "pk_live_brbnkexKijAIf5gxInl4CBgc00IzBRdphg")
  end

  def success(conn, _params) do
    render(conn, "success.html", site_domain: "beewell.yoga")
  end

  def canceled(conn, _params) do
    render(conn, "canceled.html", site_domain: "beewell.yoga")
  end

  def checkout(conn, _params) do
    {:ok, session} = Stripe.Session.create(%{
    payment_method_types: ["card"],
    line_items: [%{
      name: "Yoga Book Support",
      amount: String.to_integer(_params["contribution"]) * 100,
      currency: "usd",
      quantity: 1,
    }],
    success_url: "https://www.beewell.yoga/success",
    cancel_url: "https://www.beewell.yoga/cancel",
    submit_type: "donate"
    })
    json(conn, %{stripe_checkout_session_id: session.id})
  end
end
