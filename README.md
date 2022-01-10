# Exchange API

[![codecov](https://codecov.io/gh/liryanne/exchange_api/branch/main/graph/badge.svg?token=CGA6LENZK9)](https://codecov.io/gh/liryanne/exchange_api) [![Elixir CI](https://github.com/liryanne/exchange_api/actions/workflows/elixir.yml/badge.svg?branch=main)](https://github.com/liryanne/exchange_api/actions/workflows/elixir.yml)

https://exchangeapi-lsn.herokuapp.com/api/transactions

Exchange is a simple API service for exchange of currencies. 

Was developed using the ExchangeRates API, where conversion rates are updated in real time.

In this version, two routes are available for use: 
  * create conversion transaction 
  * transaction query by user

[Documentation API - Swagger](https://exchangeapi-lsn.herokuapp.com/api/swagger/index.html)

> [Tool](https://www.uuidgenerator.net) to generate user id.

## To run locally

Requirements: 
  * [x] Elixir 
  * [x] PostgreSQL

Create the environment variables: `DATABASE_USER` e `DATABASE_PASS`

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Specifications 

The API was developed in Elixir with Phoenix framework. The following libraries were also used:

  * [Bypass](https://hexdocs.pm/bypass/Bypass.html) - HTTP client for testing
  * [Excoveralls](https://github.com/parroty/excoveralls) - generate test coverage reports
  * [Tesla](https://github.com/teamon/tesla) - HTTP client
  * [Phoenix Swagger](https://hexdocs.pm/phoenix_swagger/PhoenixSwagger.html) - API documentation

## Learn more

  * Official website: https://www.phoenixframework.org/

