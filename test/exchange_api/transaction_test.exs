defmodule ExchangeApi.TransactionTest do
  use ExchangeApi.DataCase, async: true

  alias ExchangeApi.Transaction
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        amount: 100,
        currency_from: "EUR",
        currency_to: "BRL",
        user_id: "36da9aab-145c-4ce1-bccc-10c245a1982f"
      }

      response = Transaction.changeset(params)

      assert %Changeset{changes: %{currency_from: "EUR"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{
        amount: "amount",
        currency_to: "EUR",
        user_id: "36da9aab"
      }

      expected_response = %{
        amount: ["is invalid"],
        user_id: ["is invalid"],
        currency_from: ["can't be blank"]
      }

      response = Transaction.changeset(params)

      assert errors_on(response) == expected_response
    end
  end
end
