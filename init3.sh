#!/bin/sh
counter=0
sleep 60
while [ $counter -lt 20 ]; do
    echo The counter is $counter
    let counter=counter+1
    mongo --host "mongo-query" --port 27017 --eval "sh.addShard(\"my-mongo-set/mongo-shard1:27018,mongo-shard2:27018,mongo-shard3:27018\"); sh.enableSharding(\"test\")"
done
