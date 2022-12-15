# TurtlePosePhoenix

web visualizer for the location of turtle_sim

## Description

This example offers the integration of Rclex and [Phoenix Framework](https://www.phoenixframework.org/).
The x/y location of [turtlesim_node](https://docs.ros.org/en/foxy/Tutorials/Beginner-CLI-Tools/Introducing-Turtlesim/Introducing-Turtlesim.html), that is the most famous examle in ROS community, will be visualized on the following web page.  
http://localhost:4000/turtle

More precisely, `subpose_ex` in SubPose module subscribes Pose (`turtlesim/msg/Pose`) message from `/turtle1/pose` topic, and casts it to `:turtle` GenServer that is associated to Phoenix LiveView mechanism.

## Operation

### Building

```
source /opt/ros/foxy/setup.bash
mix deps.get
mix rclex.gen.msgs
mix compile
```

### Execution

First of all, please run turtlesim_node on the other terminal.

```
source /opt/ros/foxy/setup.bash
ros2 run turtlesim turtlesim_node
```

Then, start Phoenix server.

```
iex -S mix phx.server
```

Finally, execute `SubPose.start_pose/1` on IEx.
The argument refers to the time for subscription.

```
$ iex -S mix
iex()> TurtlePosePhoenix.SubPose.start_pose(10000)
```

You can observe the location of turtle on the following page by accessing the web browser. And also, you can see the live location according to the teleoperation of turtle by [turtle_teleop_rclex](../turtle_teleop_rclex) example.  
http://localhost:4000/turtle

Note that `/turtle1/pose` topic is published at 0.015 ms intervals. You will see a large number of output messages on the console.

## Supplimentary

### Debugging by itself

For debugging, you can cast the values on IEx by itself.

```
$ iex -S mix phx.server
iex()> GenServer.cast({:global, :turtle}, {:pose, %{x: 11, y: 22}})
```

### Connect with Erlang Node

Since `:turtle` is implemented by GenServer, you can also cast the value from TurtleTeleopRclex.SubPose module. Please check [turtle_teleop_rclex/README.md#visualization-of-pose-on-phoenix](../turtle_teleop_rclex/README.md#visualization-of-pose-on-phoenix) section for more detail.

### Associated files

```shell
config/
└── config.exs      # Rclex message types
lib/
├── turtle_pose_phoenix
│   └── server.ex   # :turtle GenServer
│   └── sub_pose.ex # SubPose module
└── turtle_pose_phoenix_web
     ├── live
     │   ├── turtle_live.ex         # implementation of LiveView
     │   └── turtle_live.html.heex  # template for LiveView
     └── router.ex  # routing for /turtle page
```

## TODO??

- [ ] XとYをいい感じに見せる
- [ ] 亀を操作できるようにする？
