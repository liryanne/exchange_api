defmodule ExchangeApi.Exchangerates.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias ExchangeApi.Error
  alias ExchangeApi.Exchangerates.Client

  describe "get_conversion_rate/2" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when success is true", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, ~s({"success": true}))
      end)

      response = Client.get_conversion_rate(url)

      assert {:ok, _} = response
    end

    test "when success is false", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, ~s({"success": false}))
      end)

      response = Client.get_conversion_rate(url)

      assert {:error, _} = response
    end

    test "when there is a generic error", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_conversion_rate(url)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
