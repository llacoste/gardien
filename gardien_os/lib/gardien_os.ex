defmodule GardienOs do
  @moduledoc """
  Documentation for GardienOs.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GardienOs.hello
      :world

  """
  def hello do
    :world
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Blinky.Blink, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Blinky.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
