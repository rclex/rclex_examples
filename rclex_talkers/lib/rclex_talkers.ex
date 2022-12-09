defmodule RclexTalkers do
  def publish_message(num_talkers) do
    context = Rclex.rclexinit()
    {:ok, nodes} = Rclex.ResourceServer.create_nodes(context, 'talker', num_talkers)

    {:ok, publishers} =
      Rclex.Node.create_publishers(nodes, 'StdMsgs.Msg.String', 'chatter', :single)

    # This sleep is essential for now
    # see Issue https://github.com/rclex/rclex/issues/212
    Process.sleep(100)

    {:ok, timer} =
      Rclex.ResourceServer.create_timer(&pub_callback/1, publishers, 1000, 'continus_timer')

    Process.sleep(10000)

    Rclex.ResourceServer.stop_timer(timer)
    Rclex.Node.finish_jobs(publishers)
    Rclex.ResourceServer.finish_nodes(nodes)
    Rclex.shutdown(context)
  end

  defp pub_callback(publishers) do
    n = length(publishers)
    msg_list = Rclex.Msg.initialize_msgs(n, 'StdMsgs.Msg.String')

    Enum.map(0..(n - 1), fn index ->
      data = "I'm No.#{index} talker. Hello World from Rclex!"
      message = %Rclex.StdMsgs.Msg.String{data: String.to_charlist(data)}
      IO.puts("Rclex: Publishing: #{message.data}")
      Rclex.Msg.set(Enum.at(msg_list, index), message, 'StdMsgs.Msg.String')
    end)

    Rclex.Publisher.publish(publishers, msg_list)
  end
end
