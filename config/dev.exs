use Mix.Config

config :phoenix, PhoenixReactTemplate.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true
