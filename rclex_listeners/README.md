# RclexListeners

simple listeners on multiple node

## Description

This example is the Rclex version of [demo_nodes_cpp/listener](https://github.com/ros2/demos/blob/rolling/demo_nodes_cpp/src/topics/listener.cpp), but multiple nodes will be created at the same time by one of the unique features on Rclex.

The multiple Rclex nodes `listenerX` subscribes string (`std_msgs/msg/String`) message from `/chatter` topic.
The number of nodes can be specified in the argument.
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
$ mix deps.get
$ iex -S mix
iex()> RclexListeners.subscribe_message(10)  # 10 Listener will subscribe at the same time
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
