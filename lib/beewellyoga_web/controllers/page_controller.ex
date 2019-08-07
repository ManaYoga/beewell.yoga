defmodule BeewellyogaWeb.PageController do
  use BeewellyogaWeb, :controller

  defp _zvz_render(conn, rendr, assigns) do
    render(conn, rendr, Map.merge(assigns, %{
      site_title: Application.get_env(:beewellyoga, BeewellyogaWeb.Endpoint)[:site_title],
      site_address: Application.get_env(:beewellyoga, BeewellyogaWeb.Endpoint)[:site_address],
      site_description: Application.get_env(:beewellyoga, BeewellyogaWeb.Endpoint)[:site_description],
      site_author: Application.get_env(:beewellyoga, BeewellyogaWeb.Endpoint)[:site_author]
      })
    )
  end

  defp _stripe_render(conn, render, assigns \\ %{}) do
    {:ok, customer_list} = Stripe.Customer.list(%{limit: 100})
    customer_count = length(customer_list.data) + 3
    {:ok, balance_transactions} = Stripe.BalanceTransaction.all(%{type: "charge", limit: 100})
    balance = Enum.reduce(balance_transactions.data, 0, fn x, acc -> x.amount + acc end) + 214100

    _zvz_render(conn, render, Map.merge(assigns, %{
      stripe_publishable_key: "pk_live_brbnkexKijAIf5gxInl4CBgc00IzBRdphg",
      stripe_payments_total: balance,
      fundraising_goal: 1500000,
      backer_count: customer_count
    }))
  end

  def index(conn, _params) do
    _stripe_render(conn, "index.html")
  end

  def success(conn, _params) do
    _stripe_render(conn, "success.html")
  end

  def canceled(conn, _params) do
    _stripe_render(conn, "canceled.html")
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
