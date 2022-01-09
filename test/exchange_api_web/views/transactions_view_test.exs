defmodule ExchangeApiWeb.TransactionsViewTest do
  use ExchangeApiWeb.ConnCase, async: true

  import Phoenix.View

  alias ExchangeApiWeb.TransactionsView
  alias ExchangeApi.Transaction

  @transaction %Transaction{
    amount: 100,
    currency_from: "EUR",
    currency_to: "SAR",
    user_id: "36da9aab-145c-4ce1-bccc-10c245a1982f"
  }

  test "renders create.json" do
    response = render(TransactionsView, "create.json", transaction: @transaction)

    expected_response = %{message: "Transaction created!", transaction: @transaction}

    assert expected_response == response
  end

  test "renders show.json" do
    response = render(TransactionsView, "show.json", transactions: [@transaction])

    expected_response = %{
      count: 1,
      data: [
        %{
          transaction: @transaction
        }
      ]
    }

    assert expected_response == response
  end
end
