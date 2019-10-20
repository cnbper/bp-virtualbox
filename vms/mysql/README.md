# mysql vms

## 参考文档

- <https://dev.mysql.com/doc/refman/5.7/en/source-installation.html>
- <https://dev.mysql.com/doc/refman/5.7/en/installing-source-distribution.html>
- <https://dev.mysql.com/doc/refman/5.7/en/source-configuration-options.html>

## 安装包准备

- 下载以下安装包并放到downloads文件夹

```shell
wget http://nchc.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.24.tar.gz
# wget https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.17.tar.gz
```

## 启动

```shell
vagrant up

# 停止
vagrant halt
```

## 重置root密码

- root 用户登录到虚机

```shell
vagrant ssh
sudo -i

# Login to MySQL，初始密码可在 temp/initdb.log 中找到
/usr/local/mysql/bin/mysql -u root -p

# 修改root初始密码
mysql> ALTER USER 'root'@'localhost' identified by 'sloth@linux';
# 允许root外部访问
mysql> use mysql
mysql> GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'sloth@linux';
```
