defmodule ExchangeApiWeb.Router do
  use ExchangeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExchangeApiWeb do
    pipe_through :api

    post "/transactions/", TransactionsController, :create
    get "/transactions/user/:id", TransactionsController, :show
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :exchange_api,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Exchange API",
        description: "API Documentation for Exchange API v1",
        termsOfService: "Open for public"
      }
    }
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ExchangeApiWeb.Telemetry
    end
  end
end
