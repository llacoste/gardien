defmodule GardienOs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GardienOs.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: GardienOs.Worker.start_link(arg)
        # {GardienOs.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: GardienOs.Worker.start_link(arg)
      # {GardienOs.Worker, arg},
    ]
  end

  def children(_target) do
    platform_init(System.get_env("MIX_TARGET"))
    webengine_opts = Application.get_all_env(:webengine_kiosk)
    [
      # Children for all targets except host
      # Starts a worker by calling: GardienOs.Worker.start_link(arg)
      # {GardienOs.Worker, arg},
      Blinky.Blink,
      {WebengineKiosk, {webengine_opts, name: Display}}
    ]
  end

  def target() do
    Application.get_env(:gardien_os, :target)
  end

  defp platform_init("host"), do: :ok

  defp platform_init(_target) do
    :os.cmd('udevd -d')
    :os.cmd('udevadm trigger --type=subsystems --action=add')
    :os.cmd('udevadm trigger --type=devices --action=add')
    :os.cmd('udevadm settle --timeout=30')

    System.put_env("QTWEBENGINE_CHROMIUM_FLAGS", "--disable-gpu")
  end
end
