defmodule Blinky.Blink do
  @moduledoc """
  Simple module to make a GPIO light blink.
  """
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    {:ok, gpio} = Circuits.GPIO.open(21, :output)
    Process.send_after(self(), :blink_on, 500)
    {:ok, gpio}
  end

  def handle_info(:blink_on, gpio) do
    Circuits.GPIO.write(gpio, 1)
    Process.send_after(self(), :blink_off, 1000)
    {:noreply, gpio}
  end

  def handle_info(:blink_off, gpio) do
    Circuits.GPIO.write(gpio, 0)
    Process.send_after(self(), :blink_on, 1000)
    {:noreply, gpio}
  end
end
