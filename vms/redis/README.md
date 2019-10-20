# redis vms

## 参考文档

- <https://redis.io/download>
- <http://www.redis.cn/topics/cluster-tutorial.html>

## 安装包准备

- 下载以下安装包并放到downloads文件夹

```shell
wget http://download.redis.io/releases/redis-4.0.14.tar.gz
```

## 安装注意事项

```shell
vagrant up
```

- **注意：安装完需重启虚机，使优化配置生效**

```shell
vagrant halt && vagrant up
```

## 常用操作

```shell
# 建立连接，登录同时验证
redis-cli -c -h 127.0.0.1 -p 6379 -a redis@linux

# 建立连接，先登录后验证
$ redis-cli -c -h 127.0.0.1 -p 6379
127.0.0.1:6379> auth redis@linux
OK

# 停止
$ redis-cli -h 127.0.0.1 -p 6379 -a redis@linux shutdown

# 查看连接数
$ redis-cli -h 127.0.0.1 -p 6379 -a redis@linux info | grep connected_clients

## 查询key
keys *
## 删除key
del keyname
## 写入记录
set key value
## 读取记录
get key
## 设置过期时间
expire key seconds
## 查看剩余生存时间
ttl key
## 查看时间戳与微秒数
TIME
## 查看当前库中的key数量
DBSIZE
## 后台进程重写AOF（手动执行重写aof，即不达到aof要求也不管）
BGREWRITEAOF
## 后台保存rdb快照（新启进程保存）
BGSAVE
## 保存rdb快照（进程阻塞保存）
SAVE
## 上次保存时间（通过了解上次保存时间，大致了解丢失了多少数据）
LASTSAVE
## 显示服务器全部信息
INFO
## 显示服务器内存信息
info Memory
## 显示状态信息
info Stats
## 断开连接,关闭服务器,不保存数据
SHUTDOWN NOSAVE
## 断开连接,关闭服务器,保存数据
SHUTDOWN SAVE
## FLUSHALL 清空所有db（清除所有库的所有键）
## FLUSHDB  清空当前db（清除当前库的所有键）

## SLOWLOG 显示慢查询
## CONFIG GET 获取配置信息
## CONFIG SET 设置配置信息
## MONITOR 打开控制台
## SYNC 主从同步
## CLIENT LIST 客户端列表
## CLIENT KILL 关闭某个客户端
## CLIENT SETNAME 为客户端设置名字
## CLIENT GETNAME 获取客户端名字
```

