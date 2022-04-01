import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hangman_live, HangmanLiveWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "ZxhK10gXCHhsE7YUoTnfs2v5vkFWi9nKWD9mLp6YhgUo3cSSukED11dkaZ/E7Yu0",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
