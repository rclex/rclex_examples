# RclexTalker

simple talker on single node

## Description

This example is the Rclex version of [demo_nodes_cpp/talker](https://github.com/ros2/demos/blob/rolling/demo_nodes_cpp/src/topics/talker.cpp).

The Rclex node `talker` publishes string (`std_msgs/msg/String`) message to `/chatter` topic every 1,000 ms.
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
iex()> RclexTalker.publish_message
```

You can confirm published messages by several ways.

```
# way 1: echo topic by ROS 2 command
source /opt/ros/foxy/setup.bash
ros2 topic echo /chatter std_msgs/msg/String

# way 2: listen by Rclcpp demos
source /opt/rof/foxy/setup.bash
ros2 run demo_nodes_cpp listener

# way 3: listen by Rclex example
cd rclex_examples/rclex_listener
# (build project, see rclex_listener directory)
iex -S mix
iex()> RclexListener.subscribe_message
```
