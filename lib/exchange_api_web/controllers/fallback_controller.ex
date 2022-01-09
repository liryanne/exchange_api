defmodule ExchangeApiWeb.FallbackController do
  use ExchangeApiWeb, :controller

  alias ExchangeApi.Error
  alias ExchangeApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: changeset_or_message}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset_or_message)
  end
end
