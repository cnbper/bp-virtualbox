# mongo vm

## 参考文档

- <https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/>

## 启动

```shell
vagrant up

# 停止
vagrant halt
```

## 初始化用户信息

```shell
vagrant ssh
sudo -i

mongo --host=172.17.8.155 --port 27017
```

- 增加用户授权

```sql
> show dbs
> use admin
> db.createUser({user:"root",pwd:"sloth@linux",roles:[{role:'userAdminAnyDatabase',db:'admin'}]})
```
