defmodule ExchangeApi.Transactions.Create do
  alias ExchangeApi.{Transaction, Repo}

  alias ExchangeApi.Transaction

  def call(%{} = params) do
    params
    |> Transaction.changeset()
    |> Repo.insert()
  end

  def call(_anything), do: "Enter the data in a map format"
end
