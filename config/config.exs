# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :trz,
  ecto_repos: [Trz.Repo]

# Configures the endpoint
config :trz, TrzWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t5ajE93Nm9P0qZWmTbyDomZpdGvCbDSmj748siwSzGnfjf/xmrDWWswo0Nfn/FyL",
  render_errors: [view: TrzWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Trz.PubSub,
  live_view: [signing_salt: "wz4LWDjI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
