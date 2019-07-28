#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

yum -y install cmake ncurses-devel bison make gcc gcc-c++

groupadd mysql
useradd -r -g mysql -s /bin/false mysql

tar zxf /vagrant/downloads/boost_1_59_0.tar.gz
mv boost_1_59_0 /usr/local/boost

tar zxf /vagrant/downloads/mysql-5.7.24.tar.gz && cd mysql-5.7.24/ && mkdir bld && cd bld/

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DDOWNLOAD_BOOST=OFF -DWITH_BOOST=/usr/local/boost -DMYSQL_TCP_PORT=3306 ..

make && make install

mkdir /opt/mysql && mkdir /opt/mysql/data && mkdir /opt/mysql/log && touch /opt/mysql/log/mariadb.log

chown -R mysql:mysql /opt/mysql

# 强制调整配置文件
\cp /vagrant/conf/my.conf /etc/my.cnf

# 初始化mysql 系统数据表
/usr/local/mysql/bin/mysqld --initialize --user=mysql > /vagrant/temp/initdb.log 2>&1

# 配置自启动
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql.server
chmod 755 /etc/init.d/mysql.server
chkconfig --add mysql.server

# 启动mysql
service mysql.server start
