import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# Start the phoenix server if environment is set and running in a  release
if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :food_order, FoodOrderWeb.Endpoint, server: true
end

if config_env() == :prod do
  config :waffle,
    storage: Waffle.Storage.Google.CloudStorage,
    bucket: System.get_env("GCP_BUCKET")


  config :goth,
    json: "{\n  \"type\": \"service_account\",\n  \"project_id\": \"trans-market-344521\",\n  \"private_key_id\": \"7f2b86b81ca6426f2c9ea753a6549f1527107941\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC2zKkMO3ThohjK\\nEPtgYTor0rdEqFoVQf4NuiCPnHP31EkpCLGWR+GJoFULdxs3wCn2nIHvjCgp442s\\n/5bIhKmHzGIAR7yOtrtn4xB/ltQbtlZgskKaT6Ht5LyH3IKAcv53BsVzime5Saom\\nf6ECt2pXZLnYaGyqLUDBuorz4ka7uVU/jg6u6V8kgk+5YQZKZacvVRzmz5NoCS7b\\nCO4LStGFwz7gAUtnh7WkVB5dC+bMZBHSw8Tku2BlgUkMZu8x1pYSwn98M1VClBjQ\\n7g8okKaIm+3bzpEqHQgyPlcIPvIRNG5dbq9BRKggy0il5JzRcO00hxsz6W7QB/sI\\nBodcvNVBAgMBAAECggEAEcOpfp5SjqYi3umFPEmxOQFaZ7TX7ZlDAqYpXuYXNlOD\\neUDhMoJcGR9N1HY9Mg7zJQZIRvVpu8m42Bc4hIEGkUNb7Ly2nBncSXgSqjYyo691\\nt8zrAGBSaLIiCNlK4ge1fJoEWzpCjTTq8PXV5FPbD5DNfLSH3DEsn1xXqjloTVAc\\nYHo6WEc5ytUnLsZ+ztaJyRdgFqSVVJmesAhxkjaypz7NIPuFgmXX4u2phnwCbLsm\\nEoPzK8aybOEQjLo+G8v8vXXWSdxAmd5+0HRPshzCBQnX+iFsZp6AdW7Iy0e3wRcq\\nU97nQC/btieQU8QIwH1yURTYvzN553qVNRxvTincbwKBgQDuFegqdYyZLw7+bcCI\\nCjaAN4ulQdIqNha4pgEuth3JUrJ++h2lP8YjZlMte/qePPdL/5h8Pr3sFmIkZ8ub\\nSuM+GON4cbIMPbj8gUpyHITILywTbOxvRWH6WoN0XPAGFf5QyY4+y+I1xTM1+6u+\\n9aoyM5cPblQQkeZ612yRedUSbwKBgQDEjc/E6wSfBSmZExIwr7M3kfwbVZAZg1hy\\nZwq5ccVkhJq02lVo95uI31PMtCyWMgODw2Xm20E1pcVLjCSAl27Nq9rYBjBkkXoS\\nGMDj2SWiqrfdAbc3KXncMmbfuAlVuwkQ69X4WZrb25Kq1TC0yL/AOl03w55JkFTp\\nChMkABSrTwKBgQCamlUphS2op1tIMoLMlD0x41/mDyjnSjpU609nQtFy0yWfuNEZ\\nZqFGiYLHzXM/3/0CN9aQD7oKnbpbQ59+lxGbWFQV+VaSBl6icV6jXQuIZsFrV9bs\\nppRqGu6z2Enw2cVMNqYM9x5MpmKL0oKDPUmo0cFtPsqN/AA7krooeYG4NwKBgQCj\\nCqttQjIcIrEl3A77udMk5oDEv83/i9djVpwrxfcicWjPWkj9AF/RQseFh3Nwx13o\\n/73YqMlH0hF9oGtrC7KLAuJOzZt44L/soQHoPukcLRbFSjYLmOkPwfNZ4pRDvBlC\\nIw7jqphthY79DEkRvXBp6UAIEMmNZh85C/ViqHp8uwKBgQDWwyhOCxGEyereLycO\\nUUkIrMFpsfVf0oCvAx1n2MdiQbZkB4iA4Zld6zLzWqR2QppqsSvWvEXV8IQA7xgx\\nfV1b0r7rJa4kuLnElKWIeKWVlRCTWZaPvnszMAj5GsXO6x7V0aDWt2sYbgxXs5bk\\nKg5vabhyPHgy/xxnndeQDT4eEA==\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"bucket-elxpro-permissao@trans-market-344521.iam.gserviceaccount.com\",\n  \"client_id\": \"109806411040447554390\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/bucket-elxpro-permissao%40trans-market-344521.iam.gserviceaccount.com\"\n}\n"

  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :food_order, FoodOrder.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2"),
    socket_options: maybe_ipv6

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :food_order, FoodOrderWeb.Endpoint,
    url: [host: host, port: 443],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    check_origin: false

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :food_order, FoodOrderWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :food_order, FoodOrder.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
