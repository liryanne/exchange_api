defmodule ExchangeApi.Transaction do
  use Ecto.Schema

  import Ecto.Changeset

  alias ExchangeApi.Exchangerates.Client
  alias ExchangeApi.Error

  @fields_that_can_be_changed [
    :user_id,
    :currency_from,
    :amount,
    :currency_to,
    :amount_converted
  ]

  @required_fields [
    :user_id,
    :currency_from,
    :amount,
    :currency_to
  ]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @derive {Jason.Encoder,
           only: [
             :id,
             :amount,
             :conversion_rate,
             :currency_from,
             :currency_to,
             :user_id,
             :amount_converted,
             :inserted_at
           ]}

  schema "transactions" do
    field :amount, :float
    field :conversion_rate, :float
    field :currency_from, :string
    field :currency_to, :string
    field :user_id, Ecto.UUID
    field :amount_converted, :float, virtual: true

    timestamps()
  end


  def build({:error, _} = changeset), do: changeset
  def build(changeset), do: apply_action(changeset, :insert)

  defp get_conversion_rate(%Ecto.Changeset{valid?: true, changes: %{}} = changeset) do
    conversion_rate = get_field(changeset, :conversion_rate)

    if is_nil(conversion_rate) do
      currency_from = get_field(changeset, :currency_from)
      currency_to = get_field(changeset, :currency_to)

      # conversion_rate = 2.9
      result = Client.get_conversion_rate(currency_to, currency_from)

      with {:ok, conversion_rate} <- result do
        put_change(changeset, :conversion_rate, conversion_rate)

      else
        {:error, %Error{}} = error -> error
        {:error, result} -> {:error, Error.build(:bad_request, result)}
      end
    else
      changeset
    end
  end

  defp get_conversion_rate(%Ecto.Changeset{valid?: false, changes: %{}} = changeset) do
    put_change(changeset, :conversion_rate, 0)
  end

  defp get_amount_converted(%Ecto.Changeset{valid?: true, changes: %{}} = changeset) do
    amount = get_field(changeset, :amount)
    conversion_rate = get_field(changeset, :conversion_rate) || 0.0

    put_change(changeset, :amount_converted, amount * conversion_rate)
  end

  defp get_amount_converted(%Ecto.Changeset{valid?: false, changes: %{}} = changeset) do
    put_change(changeset, :amount_converted, 0)
  end

  defp get_amount_converted({:error, _} = changeset), do: changeset

  def changeset(struct \\ %__MODULE__{}, %{} = params) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(@required_fields)
    |> get_conversion_rate()
    |> get_amount_converted()
  end
end
