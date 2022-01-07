defmodule ExchangeApiWeb.TransactionsView do
  use ExchangeApiWeb, :view

  alias ExchangeApi.Transaction

  def render("create.json", %{transaction: %Transaction{} = transaction}) do
    %{
      message: "Transaction created!",
      transaction: transaction
    }
  end
end
