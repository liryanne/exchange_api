defmodule ExchangeApi.Exchangerates.Client do
  use Tesla

  plug Tesla.Middleware.JSON

  alias ExchangeApi.Error
  alias Tesla.Env

  @base_url "http://api.exchangeratesapi.io/latest"
  @access_key "#{System.get_env("ACCESS_KEY")}"

  def get_conversion_rate(url \\ @base_url, currency \\ "EUR") do
    url
    |> get(query: [access_key: @access_key, base: currency])
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"success" => false} = error}}) do
    {:error, Error.build(:bad_request, error["error"]["type"])}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body["rates"]}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
