import Config

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

  config :meteor, MeteorWeb.Endpoint,
    http: [
      ip: {0, 0, 0, 0},
      port: String.to_integer(System.get_env("METEOR_PORT") || "4000")
    ],
    secret_key_base: System.get_env("SECRET_KEY_BASE") || "x/mm6Ym5YyxCdmSkmSRmG5sypohljjwpHPhZoVxr+uuVle3W0BqK3Y6hwhkh/d7v",
    server: true,
    check_origin: false
end
