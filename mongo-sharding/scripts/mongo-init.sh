#!/bin/bash

#configSrv
docker compose exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
    configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
EOF

#shard1
docker compose exec -T shard1_1 mongosh --port 27018 <<EOF
rs.initiate(
  {
    _id : "shard1",
    members: [
      { _id : 0, host : "shard1_1:27018" },
      { _id : 0, host : "shard1_2:27018" },
      { _id : 0, host : "shard1_3:27018" },      
    ]
  }
);
EOF
#shard2
docker compose exec -T shard2_1 mongosh --port 27023 <<EOF
rs.initiate(
  {
    _id : "shard2",
    members: [
      { _id : 1, host : "shard2_1:27023" },
      { _id : 1, host : "shard2_2:27023" },
      { _id : 1, host : "shard2_3:27023" },      
    ]
  }
);
EOF
#router
docker compose exec -T mongos_router mongosh --port 27020 <<EOF
sh.addShard( "shard1/shard1:27018");
sh.addShard( "shard2/shard2:27023");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
EOF
