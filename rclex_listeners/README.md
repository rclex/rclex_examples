# RclexListeners

This is many talkers demo.

## Installation
Rclex requires a ROS2 environment and build essentials.
Please setup the ros environment before running the demo.

## Run demo
Run the ROS2 talker or RclexTalker.

```
$ mix deps.get
$ iex -S mix
iex > RclexListeners.subscribe_message(10)  # 10 Listener will subscribe at the same time
```
