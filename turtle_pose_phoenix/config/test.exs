import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :turtle_pose_phoenix, TurtlePosePhoenixWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "7+uUAbHNhwh5fTI0t5q4JOFoEP+0Uv+eLCjPzkqltlLvwBfSPUfKnhfJLSG/Leas",
  server: false

# In test we don't send emails.
config :turtle_pose_phoenix, TurtlePosePhoenix.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
