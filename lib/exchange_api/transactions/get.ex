defmodule ExchangeApi.Transactions.Get do
  import Ecto.Query, warn: false

  alias ExchangeApi.{Repo, Transaction, Error}

  def by_user(user_id) do
    case Ecto.UUID.cast(user_id) do
      :error ->
        {:error, Error.build(:bad_request, "user id is invalid")}

        {:ok, uuid} ->
          query =
            from t in Transaction,
              where: t.user_id == ^uuid,
              select: t,
              order_by: t.inserted_at

          result =
            Repo.all(query)
            |> Enum.map(fn t -> %{t | amount_converted: t.amount * t.conversion_rate} end)

          {:ok, result}
    end
  end
end
