defmodule ExchangeApiWeb.TransactionsController do
  use ExchangeApiWeb, :controller

  alias ExchangeApi.Transaction
  alias ExchangeApiWeb.FallbackController

  action_fallback FallbackController

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
end
