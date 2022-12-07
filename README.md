# rclex_examples

This repository offers the examples of [Rclex](https://github.com/rclex/rclex), that is ROS 2 client library for Elixir.

## Example lists

Each example project is located in a subdirectory. Please refer to the respective README for operating instructions.

- Rclex_talker        : simple talker on single node
- Rclex_talkers       : simple talkers on multiple nodes
- Rclex_listener      : simple listener on single node
- Rclex_listener      : simple listeners on multiple nodes
- turtle_teleop_rclex : teleoperation for turtle_sim from the key input
- turtle_pose_phoenix : web visualizer of the value of /pose in turtle_sim

## Environment

Currently, we have tested the operation of examples in the following environmet.

- Ubuntu 20.04.2 LTS (Focal Fossa)
- ROS 2 [Foxy Fitzroy](https://docs.ros.org/en/foxy/Releases/Release-Foxy-Fitzroy.html)
- Elixir 1.13.4-otp-25
- Erlang/OTP 25.0.3
- Rclex [v0.8.2](https://hexdocs.pm/rclex/0.8.2/readme.html)

Please also refer to [rclex documentation](https://github.com/rclex/rclex#recommended-environment) for more detail.

## Quickstart

We also we provide [rclex_docker](https://github.com/rclex/rclex_docker) environment to try out the examples right away.
Let's get a quick start using the Docker environment!

```
$ cd your_woking_directry
$ git clone https://github.com/rclex/rclex_examples.git
$ cd rclex_examples/
$ docker compose run --rm rclex_docker /bin/bash
# inside container, change directory example one, this time `rclex_listener`
root@************:/# cd /root/rclex_examples/rclex_listener/
root@************:~/rclex_examples/rclex_listener# mix deps.get
...
# try example function
root@************:~/rclex_examples/rclex_listener# iex -S mix
iex(1)> RclexListener.subscribe_message

12:38:12.341 [debug] JobExecutor start

12:38:12.344 [debug] listener/chatter/sub subscriber process start

12:38:22.352 [debug] subscriber finished: listener/chatter/sub

12:38:22.353 [debug] finish node: listener
{:ok, #Reference<0.2781152389.209059862.173351>}
```
