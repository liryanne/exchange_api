defmodule ExchangeApi.Exchangerates.Client do
  use Tesla

  plug Tesla.Middleware.JSON

  alias ExchangeApi.Error
  alias Tesla.Env

  @base_url "http://api.exchangeratesapi.io/latest"
  @access_key "#{System.get_env("ACCESS_KEY")}"

  def get_conversion_rate(currency_to, currency_from, url \\ @base_url) do
    url
    |> get(query: [access_key: @access_key, base: currency_from])
    |> handle_get(currency_to)
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"success" => false} = error}} , _) do
    {:error, Error.build(:bad_request, error["error"]["type"])}
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"success" => true} = body}}, currency_to) do
    rate = body["rates"][currency_to]

    if is_nil(rate) do
      {:error, Error.build(:bad_request, "conversion_currency_is_invalid")}
    else
      {:ok, rate}
    end
  end

  defp handle_get({:error, reason}, _) do
    {:error, Error.build(:bad_request, reason)}
  end
end
