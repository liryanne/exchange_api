defmodule ExchangeApiWeb.TransactionsControllerTest do
  use ExchangeApiWeb.ConnCase, async: true

  describe "create/2" do

    @valid_params %{
      amount: 100,
      currency_from: "EUR",
      currency_to: "SAR",
      user_id: "0a418b62-bc2b-43dd-97f6-d81f5b90767a"
    }

    test "when all params are valid, creates the transaction", %{conn: conn} do
      response =
        conn
        |> post(Routes.transactions_path(conn, :create, @valid_params))
        |> json_response(:created)

      expected_response =
        %{
          "message" => "Transaction created!",
          "transaction" => %{}
        }

      assert expected_response["message"] == response["message"]
    end

    test "when are invalid params, returns the error", %{conn: conn} do
      invalid_params = %{user_id: "12345"}

      response =
        conn
        |> post(Routes.transactions_path(conn, :create, invalid_params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "amount" => ["can't be blank"],
          "currency_from" => ["can't be blank"],
          "currency_to" => ["can't be blank"],
          "user_id" => ["is invalid"]
        }
      }

      assert expected_response == response
    end
  end

end
