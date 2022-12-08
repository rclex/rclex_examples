# RclexTopic

pub/sub communication on the same node to single topics

## Description

This example offers the implementation of the node that simultaneously publish and subscribe to the same topic.

The Rclex node `selfie_pubsub` publishes string (`std_msgs/msg/String`) message to `/chatter` topic every 1,000 ms.
In addition,`selfie_pubsub` also subscribes string (`std_msgs/msg/String`) message from `/chatter` topic.
The nodes will terminate after 10,000 ms has elapsed.

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
iex()> RclexTopic.selfie_pubsub
```

You can confirm the messages for publication/subscription by several ways.
Please refer to the other examples for more details.
