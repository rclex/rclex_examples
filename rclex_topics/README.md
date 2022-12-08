# RclexTopics

pub/sub communication on multiple nodes to corresponding topics

## Description

This example offers the implementation of the nodes that simultaneously publish and subscribe to the same topic.
The multiple topics will be created at the same time by one of the unique features on Rclex.

The multiple Rclex nodes `selfie_pubsubX` publishes string (`std_msgs/msg/String`) message to `/chatterX` topic every 1,000 ms.
In addition,`selfie_pubsubX` also subscribes string (`std_msgs/msg/String`) message from `/chatterX` topic.
The `X` of nodes and topics correspond to each other.
The number of nodes and topics can be specified in the argument.
The nodes will terminate after 10,000 ms has elapsed.

This example includes separate implementations of talkers and subscribers.  
In `RclexTopic.Talkers`, the multiple Rclex nodes `talkerX` publishes string (`std_msgs/msg/String`) message to `/chatterX` topic every 1,000 ms.
Also, in `RclexTopic.Listeners`, the multiple Rclex nodes `listenerX` subscribes string (`std_msgs/msg/String`) message from `/chatterX` topic.

## Operation

### Building

```
source /opt/ros/foxy/setup.bash
mix deps.get
mix rclex.gen.msgs
mix compile
```

### Execution

#### Selfie pub/sub

```
$ mix deps.get
$ iex -S mix
iex()> RclexTopics.selfie_pubsub(10)  # 10 Nodes will publish and subscribe to corresponding topics at the same time
```

You can confirm the messages for publication/subscription by several ways.
Please refer to the other examples for more details.

#### Talkers

```
$ mix deps.get
$ iex -S mix
iex()> RclexTopics.Talkers.publish_message(10)  # 10 Talkers will publish to corresponding topics at the same time
```

You can confirm published messages by several ways.

```
# way 1: echo topic by ROS 2 command
source /opt/ros/foxy/setup.bash
ros2 topic echo /chatter0 std_msgs/msg/String  # you can confirm from other topics, e.g., /chatter1, /chatter9

# way 2: listen by Rclex example
cd rclex_examples/rclex_topics
# (build project, see rclex_listener directory)
iex -S mix
iex()> RclexTopics.Listeners.subscribe_message(10)  # 10 Listeners will subscribe to corresponding topics at the same time
```

#### Listeners

```
$ mix deps.get
$ iex -S mix
iex()> RclexTopics.Listeners.subscribe_message(10)  # 10 Listeners will subscribe to corresponding topics at the same time
```

You can confirm published messages by several ways.

```
# way 1: echo topic by ROS 2 command
source /opt/ros/foxy/setup.bash
ros2 topic pub /chatter0 std_msgs/msg/String '{data: Hello from cmd!}'  # you can confirm from other topics, e.g., /chatter1, /chatter9

# way 2: listen by Rclex example
cd rclex_examples/rclex_topics
# (build project, see rclex_listener directory)
iex -S mix
iex()> RclexTopics.Talkers.publish_message(10)  # 10 Talkers will publish to corresponding topics at the same time
```
