#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

yum -y install cmake ncurses-devel bison make gcc gcc-c++

tar zxf /vagrant/downloads/redis-4.0.14.tar.gz && cd redis-4.0.14
make
cd src && make PREFIX=/usr/local/redis install

cat >> ~/.bash_profile<< EOF
export PATH=$PATH:/usr/local/redis/bin
EOF
source ~/.bash_profile

# 强制调整配置文件
\cp /vagrant/conf/sysctl.conf /etc/sysctl.conf
sysctl -p

# Linux增加打开文件/文件描述符的最大数量（FD）
cat << EOF >> /etc/security/limits.conf
root soft nofile 10240
root hard nofile 20480
EOF

cat << EOF >> /etc/rc.d/rc.local
if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
   echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
   echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
EOF
chmod +x /etc/rc.d/rc.local

# redis单机启动配置
mkdir -p /opt/redis/redis-single
cp /vagrant/conf/redis-single/redis-6379.conf /opt/redis/redis-single/redis-6379.conf

cp /vagrant/conf/redis-single/redis_init_script /etc/init.d/redis.server
chmod 755 /etc/init.d/redis.server
chkconfig --add redis.server

service redis.server start
