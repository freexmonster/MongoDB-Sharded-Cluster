#!/bin/sh
counter=0
sleep 20
while [ $counter -lt 10 ]; do
    echo The counter is $counter
    let counter=counter+1
    mongo --host "mongo-shard1" --port 27018 --eval "rs.initiate({_id : \"my-mongo-set\",members: [{ _id : 0, host : \"mongo-shard1:27018\"  },{ _id : 1, host : \"mongo-shard2:27018\"  },{ _id : 2, host : \"mongo-shard3:27018\"  }]})"
done
