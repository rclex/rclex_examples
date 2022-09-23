defmodule TurtleTeleopRclex.TeleopKey do
  def start_teleop do
    context = Rclex.rclexinit()
    {:ok, nodename} = Rclex.ResourceServer.create_node(context, 'teleop_ex')
    {:ok, publisher_id} = Rclex.Node.create_publisher(nodename, 'GeometryMsgs.Msg.Twist', 'turtle1/cmd_vel')
    IO.puts("Use W|A|S|D|X keys to move the turtle. Quit 'Q' to quit.")
    teleop_loop(publisher_id)
  end

  def teleop_loop(publisher_id) do
    getch()
    |> twist_get
    |> twist_pub(publisher_id)
    teleop_loop(publisher_id)
  end

  def getch do
    ruby_cmd = ~S"""
      ruby -e '
        require "io/console"
        @output = IO.new(4)
        @output.sync = true
        char = STDIN.getch
        @output.write(char)
      '
    """
    port = Port.open({:spawn, ruby_cmd}, [:binary, :nouse_stdio])
    receive do
      {^port, {:data, result}} -> IO.inspect(result)
    end
  end

  def twist_pub(nil, _) do
  end
  def twist_pub(data, publisher_id) do
    msg = Rclex.Msg.initialize('GeometryMsgs.Msg.Twist')
    Rclex.Msg.set(msg, data, 'GeometryMsgs.Msg.Twist')
    Rclex.Publisher.publish([publisher_id], [msg])
  end

  def twist_get("w") do
    twist_set(2.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  end
  def twist_get("a") do
    twist_set(0.0, 0.0, 0.0, 0.0, 0.0, 2.0)
  end
  def twist_get("s") do
    twist_set(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  end
  def twist_get("d") do
    twist_set(0.0, 0.0, 0.0, 0.0, 0.0, -2.0)
  end
  def twist_get("x") do
    twist_set(-2.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  end
  def twist_get("q") do
    exit("quit key was pressed")
  end
  def twist_get(_) do
    nil
  end

  def twist_set(linear_x, linear_y, linear_z, angular_x, angular_y, angular_z) do
    %Rclex.GeometryMsgs.Msg.Twist{linear: %Rclex.GeometryMsgs.Msg.Vector3{x: linear_x, y: linear_y, z: linear_z}, angular: %Rclex.GeometryMsgs.Msg.Vector3{x: angular_x, y: angular_y, z: angular_z}}
  end
end
