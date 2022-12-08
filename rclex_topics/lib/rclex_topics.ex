defmodule RclexTopics do
  def selfie_pubsub(num_nodes) do
    context = Rclex.rclexinit()
    {:ok, nodes} = Rclex.ResourceServer.create_nodes(context, 'selfie_pubsub', num_nodes)

    {:ok, publishers} =
      Rclex.Node.create_publishers(nodes, 'StdMsgs.Msg.String', 'chatter', :multi)

    {:ok, subscribers} =
      Rclex.Node.create_subscribers(nodes, 'StdMsgs.Msg.String', 'chatter', :multi)

    Rclex.Subscriber.start_subscribing(subscribers, context, &sub_callback/1)

    {:ok, timer} =
      Rclex.ResourceServer.create_timer(&pub_callback/1, publishers, 1000, 'continus_timer')

    Process.sleep(10000)

    Rclex.Subscriber.stop_subscribing(subscribers)
    Rclex.Node.finish_jobs(subscribers)
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

  defp sub_callback(msg) do
    recv_msg = Rclex.Msg.read(msg, 'StdMsgs.Msg.String')
    msg_data = List.to_string(recv_msg.data)

    IO.puts("Rclex: received msg: #{msg_data}")
  end
end
