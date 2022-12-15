# TurtleTeleopRclex

teleoperation for turtle_sim from the key input

## Description

This example offers the teleoperation of [turtlesim_node](https://docs.ros.org/en/foxy/Tutorials/Beginner-CLI-Tools/Introducing-Turtlesim/Introducing-Turtlesim.html), 
that is the most famous examle in ROS community.

The Rclex node `teleop_ex` publishes Twist (`geometry_msgs/msg/Twist`) message to `/turtle1/cmd_vel` topic according to the key input on the console.  
In addition,`subpose_ex` subscribes Pose (`turtlesim/msg/Pose`) message from `/turtle1/pose` topic, and casts its data to `:pose_server` implemented by GenServer (this value can be visualized by [turtle_pose_phoenix](../turtle_pose_phoenix)) connected with Erlang Node.

ターミナルのキー入力から`/turtle1/cmd_vel`トピックへturtlesimの制御情報を出版

## Operation

### Building

```
source /opt/ros/foxy/setup.bash
mix deps.get
mix rclex.gen.msgs
mix compile
```

### Execution

#### Teleoperation from key input

First of all, please run turtlesim_node on the other terminal.

```
source /opt/ros/foxy/setup.bash
ros2 run turtlesim turtlesim_node
```

Then, please execute `TeleopKey.start_teleop/0` on IEx.

```
$ iex -S mix
iex()> TurtleTeleopRclex.TeleopKey.start_teleop
```

The key input and operation corresponds to the following.

- W: forward
- A: turn left
- D: turn right
- X: backward
- S: stop
- Q: quit teleopration

You can confirm "turtle" will move according to the key input!

#### Subsription of pose

First of all, please execute phoenix server from `rclex_examples/turtle_pose_phoenix`, along with turtlesim_node. 
`[ip_address]` means IP address for your machine to configure the setting of Erlang Node.

```
$ cd rclex_examples/turtle_pose_phoenix
$ iex --name node1@[ip_address] --cookie c2e -S mix phx.server
iex(node1@[ip_address])> 
```

Also, please run IEx for turtle_teleop_rclex (this project) with the setting of Erlang Node.

```
$ cd rclex_examples/turtle_teleop_rclex
$ iex --name node2@[ip_address] --cookie c2e -S mix
iex(node2@[ip_address])> 
```

Then, please connect Nodes, and run `Pose.start_pose/1` (argument refers to the interval for casting the pose value to the GenServer).

```
iex(node2@[ip_address])> Node.connect(:"node1@[ip_address]")
iex(node2@[ip_address])> TurtleTeleopRclex.Pose.start_pose(500)
```
