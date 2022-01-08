defmodule ExchangeApi.Transactions.Get do
  import Ecto.Query, warn: false

  alias ExchangeApi.{Repo, Transaction}

  def by_user(user_id) do
    query =
      from t in Transaction,
        where: t.user_id == ^user_id,
        select: t,
        order_by: t.inserted_at

    result =
      Repo.all(query)
      |> Enum.map(fn t -> %{t | amount_converted: t.amount * t.conversion_rate} end)

    {:ok, result}
  end
end
