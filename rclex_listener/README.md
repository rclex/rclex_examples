# RclexListener

simple listener on single node

## Description

This example is the Rclex version of [demo_nodes_cpp/listener](https://github.com/ros2/demos/blob/rolling/demo_nodes_cpp/src/topics/listener.cpp).

The Rclex node `listener` subscribes string (`std_msgs/msg/String`) message from `/chatter` topic.
The node will terminate after 10,000 ms has elapsed.

## Operation

### Building

```
source /opt/ros/foxy/setup.bash
mix deps.get
mix rclex.gen.msgs
mix compile
```

### Execution

```
$ iex -S mix
iex()> RclexListener.subscribe_message
```

You can confirm the subscription of messages by several ways.

```
# way 1: publish topic by ROS 2 command
source /opt/ros/foxy/setup.bash
ros2 topic pub /chatter std_msgs/msg/String '{data: Hello from cmd!}'

# way 2: publish by Rclcpp demos
source /opt/rof/foxy/setup.bash
ros2 run demo_nodes_cpp talker

# way 3: publish by Rclex example
cd rclex_examples/rclex_talker
# (build project, see rclex_talker directory)
iex -S mix
iex()> RclexTalker.publish_message
```
