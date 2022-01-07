defmodule ExchangeApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, :uuid
      add :currency_from, :string
      add :amount, :float
      add :currency_to, :string
      add :conversion_rate, :float

      timestamps()
    end

  end
end
