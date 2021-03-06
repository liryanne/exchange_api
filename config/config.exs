# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :exchange_api,
  ecto_repos: [ExchangeApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :exchange_api, ExchangeApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LiTUSG7WMbhe/XC1U2INUciS1r0KQbLOaUzWM0EfprmZouX2CFL9wFlQoo+tBxLa",
  render_errors: [view: ExchangeApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExchangeApi.PubSub,
  live_view: [signing_salt: "nBLRowiM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :exchange_api, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ExchangeApiWeb.Router,
      endpoint: ExchangeApiWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
