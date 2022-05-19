defmodule RclexManyListeners do
  def subscribe_message(num_listeners) do
    context = Rclex.rclexinit()
    {:ok, nodes} = Rclex.ResourceServer.create_nodes(context, 'listener', num_listeners)
    {:ok, subscribers} = Rclex.Node.create_subscribers(nodes, 'StdMsgs.Msg.String', 'chatter', :single)
    Rclex.Subscriber.start_subscribing(subscribers, context, &sub_callback/1)

    Process.sleep(10000)

    Rclex.Subscriber.stop_subscribing(subscribers)
    Rclex.Node.finish_jobs(subscribers)
    Rclex.ResourceServer.finish_nodes(nodes)
    Rclex.shutdown(context)
  end

  defp sub_callback(msg) do
    recv_msg = Rclex.Msg.read(msg, 'StdMsgs.Msg.String')
    msg_data = List.to_string(recv_msg.data)

    IO.puts("Rclex: received msg: #{msg_data}")
  end
end
