# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, PhoenixReactTemplate.Router,
  port: System.get_env("PORT"),
  ssl: false,
  secret_key_base: "sEAP6ewJKATOmVc/+nlFBMFSI+PhJ1w6F3ucZjcz/6QQl0HeCwu/OkbqjDE7ZnF//6kw0V4yX4Z0AM8CWpLPww==",
  catch_errors: true,
  debug_errors: false,
  error_controller: PhoenixReactTemplate.PageController

# Session configuration
config :phoenix, PhoenixReactTemplate.Router,
  session: [store: :cookie,
            key: "_phoenix_react_template_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
