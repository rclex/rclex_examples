# rclex_examples
Examples for Rclex

 - Rclex_listener      : single node listener
 - Rclex_talker        : single node talker
 - Rclex_many_listener : multi nodes listener
 - Rclex_many_talker   : multi nodes talker
 - turtle_teleop_rclex : key input to turtle_sim sample
 - turtle_pose_phoenix : turtle topic web visualizer


# how to try example

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
