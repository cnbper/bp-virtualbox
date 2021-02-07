# ceph vms

## 参考文档

- <https://docs.ceph.com/docs/master/install/get-packages/>
- <https://docs.ceph.com/docs/master/install/install-ceph-deploy/>

## 初始化 & 挂载新磁盘

```shell
vagrant up
vagrant halt

# 挂载新磁盘
VBoxManage createhd --filename "/Users/zhangbaohao/software/VirtualBox VMs/cnbper-ceph/ceph-data.vdi" --size 20480
VBoxManage storageattach cnbper-ceph --storagectl "IDE" --port 1 --device 0 --type hdd --medium /Users/zhangbaohao/software/VirtualBox\ VMs/cnbper-ceph/ceph-data.vdi
```

## 创建一个Ceph集群

```shell
vagrant up
vagrant ssh

[vagrant@cnbper-ceph ~]$ sudo -i
[root@cnbper-ceph ~]$ fdisk -l
[root@cnbper-ceph ~]$ fdisk /dev/sdb

[root@cnbper-ceph ~]$ rm -rf /vagrant/cluster/cnbper-ceph
[root@cnbper-ceph ~]$ mkdir -p /vagrant/cluster/cnbper-ceph && cd /vagrant/cluster/cnbper-ceph

# 创建一个Ceph集群，生成配置文件和key文件
# https://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-new/
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy new cnbper-ceph
[root@cnbper-ceph cnbper-ceph]$ echo "osd crush chooseleaf type = 0" >> ceph.conf
[root@cnbper-ceph cnbper-ceph]$ echo "osd pool default size = 1" >> ceph.conf
[root@cnbper-ceph cnbper-ceph]$ echo "osd pool default min size = 1" >> ceph.conf
[root@cnbper-ceph cnbper-ceph]$ echo "osd journal size = 100" >> ceph.conf

# 初始化 mon，Ceph的整个集群的状态和配置信息等都是通过一个名为Monitor的集群管理的，因此首先需要启动Monitor服务。
# https://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-mon/
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy mon create-initial
# 将conf_data和keyring文件写到远端的host
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy admin cnbper-ceph
# ceph --cluster=ceph --admin-daemon /var/run/ceph/ceph-mon.cnbper-ceph.asok mon_status

# 部署ceph osd，OSD是Ceph中存储数据的节点
# https://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-osd/
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy osd create --data /dev/sdb1 cnbper-ceph

# 部署ceph mds，部署至少一个元数据服务器才能使用 CephFS 文件系统
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy mds create cnbper-ceph

# 部署ceph mgr，分担和扩展monitor的部分功能，减轻monitor的负担
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy mgr create cnbper-ceph

# 部署ceph rgw，为应用提供RESTful类型的对象存储接口
[root@cnbper-ceph cnbper-ceph]$ ceph-deploy rgw create cnbper-ceph
# 测试访问
[root@cnbper-ceph cnbper-ceph]$ curl http://127.0.0.1:7480
```

## 创建用户和bucket

```shell
# https://docs.ceph.com/docs/master/radosgw/admin/
# 在Ceph Radosgw上创建一个user和subuser
radosgw-admin user create --uid=cnbper --display-name="cnbper"
# "keys": [
#     {
#         "user": "cnbper",
#         "access_key": "IVJHPCK1T7KJ2J27THEY",
#         "secret_key": "MSn7y17w7pyQk0PQ7prPlcYGrtLlk7VlMAT8o32f"
#     }
# ]
radosgw-admin subuser create --uid=cnbper --subuser=cnbper:swift --access=full
# Note：full 并不表示 readwrite，因为它还包括访问权限策略。
# "swift_keys": [
#     {
#         "user": "cnbper:swift",
#         "secret_key": "IcnlrFQNBzCNeTcIiTABnHGlU8W7Tzqnl6hMVDUv"
#     }
# ]
# 获取用户信息
# radosgw-admin user info --uid=cnbper

# 配置用户权限：给一个用户添加对bucket的操作权限
radosgw-admin caps add --uid=cnbper --caps="buckets=*"
```

## 常用操作

```shell
# 查看集群的状态
ceph -s
# 查看实时状态
ceph -w
# 健康状态
ceph health
# 存储空间状态
ceph df

# 查看ceph集群中的认证用户及相关的key
ceph auth list

# 列举 bucket
radosgw-admin bucket list


```
