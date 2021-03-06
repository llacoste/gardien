# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :gardien_os, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1589056450"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

config :webengine_kiosk,
  fullscreen: false,
  background_color: "black",
  progress: true,
  sounds: true,
  homepage: System.get_env("NERVES_KIOSK_URL")

if Mix.target() != :host do
  import_config "target.exs"
end

import_config "../../gardien_os_ui/config/config.exs"
# import_config "../../gardien_os_ui/config/#{Mix.env()}.exs"

config :gardien_os_ui, GardienOsUiWeb.Endpoint,
  # Nerves root filesystem is read-only, so disable the code reloader
  code_reloader: false,
  debug_errors: false,
  check_origin: false,
  http: [port: 80],
  # Use compile-time Mix config instead of runtime environment variables
  load_from_system_env: false,
  # Start the server since we're running in a release instead of through `mix`
  server: true,
  url: [host: "nerves.local", port: 80]
