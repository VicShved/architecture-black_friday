#!/bin/bash

docker compose -f ./compose.yaml exec -T configSrv mongosh --port 27017 <<EOF
  rs.initiate(
    {
      _id: "config_server",
      configsvr: true,
      members: [{_id: 0, host: "configSrv:27017"}]
    }
  );
EOF

docker compose -f ./compose.yaml exec -T shard1 mongosh --port 27018 <<EOF
  rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1:27018" },
       // { _id : 1, host : "shard2:27019" }
      ]
    }
  );
EOF

docker compose -f ./compose.yaml exec -T shard2 mongosh --port 27019 <<EOF
  rs.initiate(
    {
      _id : "shard2",
      members: [
       // { _id : 0, host : "shard1:27018" },
        { _id : 1, host : "shard2:27019" }
      ]
    }
  );
EOF

sleep 10

docker compose -f ./compose.yaml exec -T router1 mongosh --port 27017 <<EOF
  sh.addShard("shard1/shard1:27018");
  sh.addShard("shard2/shard2:27019");
  sh.enableSharding("somedb");
  sh.shardCollection("somedb.helloDoc", {"name":"hashed"});
EOF


docker compose -f ./compose.yaml exec -T router1 \
  mongosh --port 27017 --quiet --eval <<EOF
    use somedb
    for (var i=0;i<1000;i++) db.helloDoc.insertOne({age:i,name:"ly"+i});
    print("вставлено: " + db.helloDoc.countDocuments());
EOF
