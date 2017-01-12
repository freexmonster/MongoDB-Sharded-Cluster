# MongoDB-Sharded-Cluster

sudo docker build -t clarkzjw/mongo-init1 -f Dockerfile.mongoinit1 .
sudo docker build -t clarkzjw/mongo-init2 -f Dockerfile.mongoinit2 .
sudo docker build -t clarkzjw/mongo-init3 -f Dockerfile.mongoinit3 .

sudo docker-compose up

sudo docker exec -it mongo-shardx(use primary node) mongo --port 27018
db.mycollection.insert({name : 'sample'})
db.mycollection.find()
db2 = (new Mongo('mongo-shardx:27017')).getDB('test')
db2.setSlaveOk()
db2.mycollection.find()
