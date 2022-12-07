# RclexTalkers

This is many talkers demo.

## Installation
Rclex requires a ROS2 environment and build essentials.
Please setup the ros environment before running the demo.

## Run demo
Run the ROS2 listener or RclexListener.

```
$ mix deps.get
$ iex -S mix
iex > RclexTalkers.publish_message(10)  # 10 Talkers will publish at the same time
```
