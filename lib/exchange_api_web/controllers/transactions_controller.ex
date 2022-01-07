defmodule ExchangeApiWeb.TransactionsController do
  use ExchangeApiWeb, :controller

  alias ExchangeApi.Transaction

  def create(conn, params) do
    with {:ok, %Transaction{} = transaction} <- ExchangeApi.create_transaction(params) do
      conn
      |> put_status(:created)
      |> render("create.json", transaction: transaction)
    end
  end
end
