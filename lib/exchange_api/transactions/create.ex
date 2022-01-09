defmodule ExchangeApi.Transactions.Create do
  alias ExchangeApi.{Transaction, Repo, Error}

  alias ExchangeApi.Transaction

  def call(%{} = params) do

    changeset = Transaction.changeset(params)

    with {:ok, %Transaction{}} <- Transaction.build(changeset),
         {:ok, %Transaction{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  def call(_anything), do: "Enter the data in a map format"
end
