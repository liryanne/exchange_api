defmodule ExchangeApiWeb.TransactionsController do
  use ExchangeApiWeb, :controller
  use PhoenixSwagger

  alias ExchangeApi.Transaction
  alias ExchangeApiWeb.FallbackController

  import Plug.Conn.Status, only: [code: 1]

  action_fallback FallbackController

  swagger_path :show do
    get "/api/transactions/user/{user_id}"
    description("List of transactions by user")
    produces "application/json"
    parameters do
      user_id :path, :string, "User ID", required: true, format: :uuid
    end
    response(code(:ok), "Success", Schema.ref(:Transactions))
    response(code(:bad_request), "Bad Request", Schema.ref(:Error))
  end

  swagger_path :create do
    post "/api/transactions"
    description("Create a currency exchange transaction")
    produces "application/json"
    parameters do
      transaction :body, Schema.ref(:Create), "Transaction attributes", required: true
    end
    response(code(:created), "Success", Schema.ref(:Response))
    response(code(:bad_request), "Bad Request", Schema.ref(:Error))
  end

  def create(conn, params) do
    with {:ok, %Transaction{} = transaction} <- ExchangeApi.create_transaction(params) do
      conn
      |> put_status(:created)
      |> render("create.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, transactions} <- ExchangeApi.get_by_user_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", transactions: transactions)
    end
  end

  def swagger_definitions do
    %{
      Error: swagger_schema do
        title "Error"
        description "When an error is returned"
        properties do
          message :string, "Error Message"
        end
        example %{
          message: "user id is invalid"
        }
      end,

      Create: swagger_schema do
        title "Create"
        description "Attributes required to create a transaction"
        properties do
          amount :number, "Transaction amount", required: true, format: :double
          currency_from :string, "Currency of origin", required: true
          currency_to :string, "Destintation currency", required: true
          user_id :string, "User ID", required: true, format: :uuid
        end
        example %{
          amount: 100.9,
          currency_from: "EUR",
          currency_to: "BRL",
          user_id: "41ee3e07-fe9f-4736-9842-84d7327dcaf1"
        }
      end,

      Response: swagger_schema do
        title "Response"
        description "Response when a transaction is created with success"
        properties do
          message :string, "Transaction created!"
          transaction Schema.ref(:Transaction), ""
        end
        example %{
          message: "Transaction created!",
          transaction: %{
            id: "373dc0b5-a0b4-48af-a3ed-fb0340683c0a",
            amount: 100.0,
            conversion_rate: 2.9,
            currency_from: "EUR",
            currency_to: "BRL",
            user_id: "41ee3e07-fe9f-4736-9842-84d7327dcaf1",
            amount_converted: 290.0,
            inserted_at: "2022-01-09T01:46:07"
          }
        }
      end,

      Transaction: swagger_schema do
        properties do
          id :string, "Transaction ID"
          amount :number, "Transaction amount", format: :double
          conversion_rate :number, "Conversion rate", format: :double
          currency_from :string, "Currency of origin"
          currency_to :string, "Destintation currency"
          user_id :string, "User ID"
          amount_converted :number, "Amount converted", format: :double
          inserted_at :utc_datetime, "When the transaction was created"
        end
        example %{
          transaction: %{
            id: "373dc0b5-a0b4-48af-a3ed-fb0340683c0a",
            amount: 100.0,
            conversion_rate: 2.9,
            currency_from: "EUR",
            currency_to: "BRL",
            user_id: "41ee3e07-fe9f-4736-9842-84d7327dcaf1",
            amount_converted: 290.0,
            inserted_at: "2022-01-09T01:46:07"
          }
        }
      end,

      Transactions: swagger_schema do
        title "Transactions"
        description "Transactions by user"
        properties do
          count :integer, "Total of transactions"
          data  Schema.array(:Transaction), "List of transactions"
        end
        example %{
          count: 1,
          data: [
            %{
              transaction: %{
                id: "373dc0b5-a0b4-48af-a3ed-fb0340683c0a",
                amount: 100.0,
                conversion_rate: 2.9,
                currency_from: "EUR",
                currency_to: "BRL",
                user_id: "41ee3e07-fe9f-4736-9842-84d7327dcaf1",
                amount_converted: 290.0,
                inserted_at: "2022-01-09T01:46:07"
              }
            }
          ]
        }
      end,

    }
  end
end
