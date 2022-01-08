defmodule ExchangeApi.Transactions.GetTest do
  use ExchangeApi.DataCase, async: true

  alias ExchangeApi.Transactions.Create
  alias ExchangeApi.Transactions.Get

  describe "by_user/1" do
    @valid_transaction %{
      amount: 999,
      currency_from: "EUR",
      currency_to: "SAR",
      user_id: "1f22dc07-8637-4e44-87c1-bb0f3b28b7d3"
    }

    def repository_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_transaction)
        |> Create.call()
    end

    test "list transaction by user id" do
      {:ok, transaction} = repository_fixture()

      expected_response = %{
        count: 1,
        data: [
          transaction |> Map.delete(:message)
        ]
      }

      {:ok, response} = Get.by_user(@valid_transaction.user_id)

      assert response == [transaction]
    end
  end
end
