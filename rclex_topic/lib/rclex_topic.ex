defmodule RclexTopic do
  def selfie_pubsub() do
    context = Rclex.rclexinit()
    {:ok, node} = Rclex.ResourceServer.create_node(context, 'selfie_pubsub')
    {:ok, publisher} = Rclex.Node.create_publisher(node, 'StdMsgs.Msg.String', 'chatter')
    {:ok, subscriber} = Rclex.Node.create_subscriber(node, 'StdMsgs.Msg.String', 'chatter')
    Rclex.Subscriber.start_subscribing(subscriber, context, &sub_callback/1)

    {:ok, timer} =
      Rclex.ResourceServer.create_timer(&pub_callback/1, publisher, 1000, 'continus_timer')

    Process.sleep(10000)

    Rclex.Subscriber.stop_subscribing(subscriber)
    Rclex.Node.finish_jobs(subscriber)
    Rclex.ResourceServer.stop_timer(timer)
    Rclex.Node.finish_jobs(publisher)
    Rclex.ResourceServer.finish_node(node)
    Rclex.shutdown(context)
  end

  defp pub_callback(publisher) do
    msg = Rclex.Msg.initialize('StdMsgs.Msg.String')
    data = "Hello World from Rclex!"
    msg_struct = %Rclex.StdMsgs.Msg.String{data: String.to_charlist(data)}
    Rclex.Msg.set(msg, msg_struct, 'StdMsgs.Msg.String')

    IO.puts("Rclex: Publishing: #{data}")
    Rclex.Publisher.publish([publisher], [msg])
  end

  defp sub_callback(msg) do
    recv_msg = Rclex.Msg.read(msg, 'StdMsgs.Msg.String')
    msg_data = List.to_string(recv_msg.data)

    IO.puts("Rclex: received msg: #{msg_data}")
  end
end
