defmodule ExchangeApiWeb.TransactionsViewTest do
  use ExchangeApiWeb.ConnCase, async: true

  import Phoenix.View

  alias ExchangeApiWeb.TransactionsView
  alias ExchangeApi.Transaction

  test "renders create.json" do
    transaction = %Transaction{
      amount: 100,
      currency_from: "EUR",
      currency_to: "SAR",
      user_id: "36da9aab-145c-4ce1-bccc-10c245a1982f"
    }

    response = render(TransactionsView, "create.json", transaction: transaction)

    assert %{message: "Transaction created!", transaction: %ExchangeApi.Transaction{}} = response
  end
end
