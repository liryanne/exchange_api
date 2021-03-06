defmodule ExchangeApi do
  @moduledoc """
  ExchangeApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias ExchangeApi.Transactions.Create, as: TransactionCreate

  alias ExchangeApi.Transactions.Get, as: TransactionGet

  defdelegate create_transaction(params), to: TransactionCreate, as: :call

  defdelegate get_by_user_id(user_id), to: TransactionGet, as: :by_user
end
