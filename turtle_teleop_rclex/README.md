# TurtleTeleopRclex
ターミナルのキー入力から`/turtle1/cmd_vel`トピックへturtlesimの制御情報を出版

## 準備
- Rclexをcloneし`v0.6.0`にcheckout
```shell
$ git clone https://github.com/rclex/rclex.git
$ cd rclex
$ git checkout v0.6.0
```
- `rclex/packages.txt`を編集してメッセージ型を指定
```
geometry_msgs/msg/Twist
turtlesim/msg/Pose
```
- `mix.exs`でRclexのパスを指定
```elixir
def deps do
  [
    {:rclex, path: "../../rclex"}
  ]
end
```
- rubyのインストール
```shell
$ apt install ruby
```
## 使い方
- turtlesimを起動しておく
```shell
$ ros2 run turtlesim turtlesim_node
```
### Teleop
- `start_teleop`関数を実行
```shell
$ mix run -e "TurtleTeleopRclex.TeleopKey.start_teleop"
```
- W|A|S|D|Xキーで移動・回転，Qキーで終了
  - W:前進
  - A:左回転
  - S:静止
  - D:右回転
  - X:後退
### Poseの購読
- `RclexExamples/TurtlePosePhoenix`からPhoenixを起動
```shell
~/rclex_examples/turtle_pose_phoenix$ iex --name node1@[ip_address] --cookie c2e -S mix phx.server
iex(node1@[ip_address])1>
```
- `RclexExamples/TurtleTeleopRclex`からiexを起動
```shell
~/rclex_examples/turtle_teleop_rclex$ iex --name node2@[ip_address] --cookie c2e -S mix
iex(node2@[ip_address])1>
```
- Node.connect()を実行
- node2で`TurtleTeleopRclex.Pose.start_pose/1`を実行
  - 引数はxy座標情報を{:global, :turtle}に送信する間隔
```shell
iex(node2@[ip_address])1> TurtleTeleopRclex.Pose.start_pose(500)
```
