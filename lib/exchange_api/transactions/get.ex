defmodule ExchangeApi.Transactions.Get do
  alias ExchangeApi.{Error, Repo, Transaction}

  def by_id(id) do
    case Repo.get(Transaction, id) do
      nil -> {:error, Error.build(:not_found, "transaction not found")}
      transaction_schema -> {:ok, transaction_schema}
    end
  end
end
