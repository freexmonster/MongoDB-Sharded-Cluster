#!/bin/sh
counter=0
sleep 10
while [ $counter -lt 10 ]; do
    echo The counter is $counter
    let counter=counter+1
    mongo --host mongo-config1 --port 27019 --eval "rs.initiate({_id: \"my-mongo-set\",configsvr: true,members: [{ _id : 0, host : \"mongo-config1:27019\"  },{ _id : 1, host : \"mongo-config2:27019\"  },{ _id : 2, host : \"mongo-config3:27019\"  }]})"
done
