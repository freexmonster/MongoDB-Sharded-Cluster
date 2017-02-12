#!/bin/sh
echo $DBNAME

counter=0
sleep 10
while [ $counter -lt 10 ]; do
    echo The counter is $counter
    let counter=counter+1
    mongo --host mongo-config1 --port 27019 --eval "rs.initiate({_id: \"my-mongo-set\",configsvr: true,members: [{ _id : 0, host : \"mongo-config1:27019\"  },{ _id : 1, host : \"mongo-config2:27019\"  },{ _id : 2, host : \"mongo-config3:27019\"  }]})"
done

counter=0
sleep 10
while [ $counter -lt 10 ]; do
    echo The counter is $counter
    let counter=counter+1
    mongo --host "mongo-shard1" --port 27018 --eval "rs.initiate({_id : \"my-mongo-set\",members: [{ _id : 0, host : \"mongo-shard1:27018\"  },{ _id : 1, host : \"mongo-shard2:27018\"  },{ _id : 2, host : \"mongo-shard3:27018\"  }]})"
done

counter=0
sleep 10
while [ $counter -lt 10 ]; do
    echo The counter is $counter
    let counter=counter+1
	if [ -z "$DBNAME" ]; then
		echo "DBNAME not set"
		echo "EnableSharding for default database 'test'"
		mongo --host "mongo-query" --port 27017 --eval "sh.addShard(\"my-mongo-set/mongo-shard1:27018,mongo-shard2:27018,mongo-shard3:27018\"); sh.enableSharding(\"test\")"
	else
		echo "EnableSharding for database $DBNAME"
		mongo --host "mongo-query" --port 27017 --eval "sh.addShard(\"my-mongo-set/mongo-shard1:27018,mongo-shard2:27018,mongo-shard3:27018\"); sh.enableSharding(\"$DBNAME\")"
    fi
done

while true; do
	echo "Shard enabled"
	sleep 3
done