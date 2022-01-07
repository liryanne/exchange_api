defmodule ExchangeApiWeb.TransactionsView do
  use ExchangeApiWeb, :view

  alias ExchangeApi.Transaction

  def render("create.json", %{transaction: %Transaction{} = transaction}) do
    %{
      message: "Transaction created!",
      transaction: transaction
    }
  end

  def render("show.json", %{transactions: transactions}) do
    %{
      count: length(transactions),
      data:
        render_many(transactions, __MODULE__, "create.json", as: :transaction)
        |> Enum.map(fn t -> Map.delete(t, :message) end)
    }
  end
end
