defmodule ExchangeApi.Transactions.CreateTest do
  use ExchangeApi.DataCase, async: true

  alias ExchangeApi.{Transaction}
  alias ExchangeApi.Transactions.Create
  alias ExchangeApi.Transaction

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = %{
        amount: 100,
        currency_from: "EUR",
        currency_to: "SAR",
        user_id: "36da9aab-145c-4ce1-bccc-10c245a1982f"
      }

      response = Create.call(params)

      assert {:ok, %Transaction{}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        amount: 100,
        currency_to: "SAR",
        user_id: "36da9aab-145c-4ce1-bccc-10c245a1982f"
      }

      response = Create.call(params)

      assert {:error, _} = response
    end
  end
end
