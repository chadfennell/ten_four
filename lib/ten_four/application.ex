defmodule TenFour.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TenFourWeb.Telemetry,
      # Start the Ecto repository
      TenFour.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TenFour.PubSub},
      # Start Finch
      {Finch, name: TenFour.Finch},
      # Start the Endpoint (http/https)
      TenFourWeb.Endpoint,
      {Typesense.Client, typsense_config()}

      # Start a worker by calling: TenFour.Worker.start_link(arg)
      # {TenFour.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TenFour.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp typsense_config() do
    %{
      api_key: "goodbuddyniner",
      nodes: [%{host: "localhost", port: "8108", protocol: "http"}]
    }
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TenFourWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
