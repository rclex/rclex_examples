defmodule TurtlePosePhoenix.Server do
  use GenServer
  require Logger

  #
  # Client API
  #
  def start_link(pname, state) do
    GenServer.start_link(__MODULE__, state, name: pname)
  end

  def stop(pname) do
    GenServer.stop(pname)
  end

  #
  # Callbacks
  #
  def handle_cast({:pose, %{x: pose_x, y: pose_y}}, state) do
    Logger.info("=== pose: #{inspect(%{x: pose_x, y: pose_y})} ===")
    send(state, {:pose, %{x: pose_x, y: pose_y}})
    {:noreply, state}
  end

  def init(state) do
    {:ok, state}
  end

  def terminate(reason, _) do
    reason
  end
end
