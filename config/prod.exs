use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :phoenix, PhoenixReactTemplate.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  secret_key_base: "sEAP6ewJKATOmVc/+nlFBMFSI+PhJ1w6F3ucZjcz/6QQl0HeCwu/OkbqjDE7ZnF//6kw0V4yX4Z0AM8CWpLPww=="

config :logger, :console,
  level: :info
