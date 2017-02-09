# MongoDB-Sharded-Cluster

当从docker-compose.yml部署的时候，由于mongo-init(1-3)这三个容器在脚本执行完成后并不会主动销毁自己这个容器，因此要从log判断，部署成功后手动停止这三个容器。

正常状态下，集群中共有7个容器。

```bash
sudo docker build -t clarkzjw/mongo-init1 -f Dockerfile.mongoinit1 .
sudo docker build -t clarkzjw/mongo-init2 -f Dockerfile.mongoinit2 .
sudo docker build -t clarkzjw/mongo-init3 -f Dockerfile.mongoinit3 .

sudo docker-compose up

#以下主从配置应该根据实际需求进行

sudo docker exec -it mongo-shardx(use primary node) mongo --port 27018
db.mycollection.insert({name : 'sample'})
db.mycollection.find()
db2 = (new Mongo('mongo-shardx:27018')).getDB('test')
db2.setSlaveOk()
db2.mycollection.find()
```
