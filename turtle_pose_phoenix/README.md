# TurtlePosePhoenix

- `GenServer.cast` された値をブラウザに表示する
  - http://localhost:4000/turtle
- プロセスの名前は `{:global, :turtle}`
- 関連ファイル

```shell
lib/
├── turtle_pose_phoenix
│   └── server.ex
└── turtle_pose_phoenix_web
     ├── live
     │   ├── turtle_live.ex
     │   └── turtle_live.html.heex
     └── router.ex
```


## 使い方１
Phoenix自身のiexで操作する場合、GenServer.castするとXとYの値を更新できる。

※`:turtle` でも良かったが、使い方２のことを考慮して `{:global, :turtle}` としている。

```shell
$ iex -S mix phx.server
iex> GenServer.cast({:global, :turtle}, {:pose, %{x: 11, y: 22}})
```


## 使い方２
別ターミナル（別ノード）から操作する場合は以下の手順で更新できる。

### （０）準備
実行するPCのIPアドレスを調べる（例：192.168.0.6）

### （１）Phoenixを起動する（ターミナルA、node1）

```shell
$ iex --name node1@192.168.0.6 --cookie c2e -S mix phx.server
iex(node1@192.168.0.6)1>
```

### （２）別ターミナルでiexを起動する（ターミナルB、node2）

別PCで起動して `GenServer.call` する場合は、IPアドレスの箇所を置き換えて実行する。

```shell
$ iex --name node2@192.168.0.6 --cookie c2e
iex(node2@192.168.0.6)1>
```

### （３）どちらのnodeからでもいいのでNode.connect()を実行する

```shell
iex(node1@192.168.0.6)1> Node.list()　←確認
[]

iex(node1@192.168.0.6)2> Node.connect(:"node2@192.168.0.6")
true

iex(node1@192.168.0.6)3> Node.list()　←確認
[:"node2@192.168.0.6"]
```

### （４）node2で以下を実行する

```shell
iex(node2@192.168.0.6)8> GenServer.cast({:global, :turtle}, {:pose, %{x: 123, y: 987}})
```

### （５）ウェブページのXとYが更新されているか確認する
http://localhost:4000/turtle


# そのうちやるかもリスト
- [ ] XとYをいい感じに見せる
- [ ] 亀を操作できるようにする？
