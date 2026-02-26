import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/meteor start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :meteor, MeteorWeb.Endpoint, server: true
end

config :meteor, MeteorWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT", "4000"))]

if config_env() == :prod do
  database_path =
    System.get_env("METEOR_DATABASE_PATH") ||
      Path.join([System.user_home() || ".", ".meteor", "meteor.db"])

  # Ensure database directory exists
  database_dir = Path.dirname(database_path)
  File.mkdir_p!(database_dir)

  config :meteor, Meteor.Repo,
    database: database_path,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5")

  config :meteor, Meteor.Endpoint,
    http: [
      ip: {0, 0, 0, 0},
      port: String.to_integer(System.get_env("METEOR_PORT") || "4000")
    ],
    secret_key_base: System.get_env("SECRET_KEY_BASE") || "x/mm6Ym5YyxCdmSkmSRmG5sypohljjwpHPhZoVxr+uuVle3W0BqK3Y6hwhkh/d7v",
    server: true,
    check_origin: false
end
