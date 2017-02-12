# MongoDB-Sharded-Cluster

正常状态下，集群中共有8个容器。当需要对数据库进行操作时，mongo客户端连接到mongo-query即可，即开放的27017端口。

在DCE上部署时，应添加一个模板变量DBNAME，代表启用Sharding的数据库名称默认值为test

```bash
sudo docker-compose up

# 以下主从配置应该根据实际需求进行

sudo docker exec -it mongo-shardx(use primary node) mongo --port 27018
db.mycollection.insert({name : 'sample'})
db.mycollection.find()
db2 = (new Mongo('mongo-shardx:27018')).getDB('test')
db2.setSlaveOk()
db2.mycollection.find()
```
