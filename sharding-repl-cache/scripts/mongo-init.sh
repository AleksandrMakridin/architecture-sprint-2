#!/bin/bash

docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id : "config-server",
    configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
EOF

sleep 1

docker compose exec -T shard1_1 mongosh --port 27018 --quiet <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1_1:27018" },
        { _id : 1, host : "shard1_2:27019" },
        { _id : 2, host : "shard1_3:27022" },
      ]
    }
);
EOF

sleep 1

docker compose exec -T shard2_1 mongosh --port 27023 --quiet <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "shard2_1:27023" },
        { _id : 1, host : "shard2_2:27024" },
        { _id : 2, host : "shard2_3:27025" }
      ]
    }
);
EOF

sleep 1

docker compose exec -T redis redis-cli
EOF

docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard("shard1/shard1_1:27018");
sh.addShard("shard2/shard1_1:27019");
sh.addShard("shard1/shard1_3:27022");
sh.addShard("shard2/shard2_1:27023");
sh.addShard("shard2/shard2_2:27024");
sh.addShard("shard2/shard2_3:27025");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
use somedb;

for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})

EOF
