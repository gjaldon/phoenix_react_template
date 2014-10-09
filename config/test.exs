use Mix.Config

config :phoenix, PhoenixReactTemplate.Router,
  port: System.get_env("PORT") || 4001,
  ssl: false
