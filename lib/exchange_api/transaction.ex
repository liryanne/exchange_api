defmodule ExchangeApi.Transaction do
  use Ecto.Schema

  import Ecto.Changeset

  @fields_that_can_be_changed  [
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
    :currency_to,
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

  @spec build(Ecto.Changeset.t()) :: {:error, Ecto.Changeset.t()} | {:ok, map}
  def build(changeset), do: apply_action(changeset, :insert)

  defp get_conversion_rate(%Ecto.Changeset{valid?: true, changes: %{}} = changeset) do
    _currency_from = get_field(changeset, :currency_from)
    _currency_to = get_field(changeset, :currency_to)

    convertion_rate = 2.9

    put_change(changeset, :conversion_rate, convertion_rate)
  end

  defp get_conversion_rate(%Ecto.Changeset{valid?: false, changes: %{}} = changeset) do
    put_change(changeset, :conversion_rate, 0)
  end

  defp get_amount_converted(%Ecto.Changeset{valid?: true, changes: %{}} = changeset) do
    amount = get_field(changeset, :amount)
    conversion_rate = get_field(changeset, :conversion_rate)

    put_change(changeset, :amount_converted, amount * conversion_rate)
  end

  defp get_amount_converted(%Ecto.Changeset{valid?: false, changes: %{}} = changeset) do
    put_change(changeset, :amount_converted, 0)
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(@required_fields)
    |> get_conversion_rate()
    |> get_amount_converted()
  end
end
