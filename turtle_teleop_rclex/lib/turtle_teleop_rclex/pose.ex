defmodule TurtleTeleopRclex.Pose do
  use GenServer

  def init(_) do
    {:ok, %Rclex.Turtlesim.Msg.Pose{}}
  end

  def handle_cast({:write, pose}, _) do
    {:noreply, pose}
  end

  def handle_call(:readout, _, pose) do
    {:reply, pose, pose}
  end

  def start_pose(interval) do
    GenServer.start_link(__MODULE__, {}, name: :pose_server)

    context = Rclex.rclexinit()
    {:ok, nodename} = Rclex.ResourceServer.create_singlenode(context, 'subpose_ex')
    {:ok, subscriber_id} = Rclex.Node.create_single_subscriber(nodename, 'Turtlesim.Msg.Pose', 'turtle1/pose')
    Rclex.Subscriber.start_subscribing([subscriber_id], context, &subpose_callback/1)
    {:ok, timer} =
      Rclex.ResourceServer.create_timer(
        &sendpose_callback/1,
        nil,
        interval,
        "sendpose_timer"
      )

    Rclex.waiting_input(:normal, timer)

    Rclex.ResourceServer.stop_timer(timer)
    Rclex.Node.finish_jobs([subscriber_id])
    Rclex.ResourceServer.finish_nodes([nodename])
    Rclex.shutdown(context)
  end

  def subpose_callback(msg) do
    data = Rclex.Msg.read(msg, 'Turtlesim.Msg.Pose')
    GenServer.cast(:pose_server, {:write, data})
  end

  def sendpose_callback(_) do
    data = GenServer.call(:pose_server, :readout)
    GenServer.cast({:global, :turtle}, {:pose, %{x: data.x, y: data.y}})
  end
end
