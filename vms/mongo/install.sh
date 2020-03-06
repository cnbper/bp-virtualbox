#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

# yum -y install --downloadonly --downloaddir=/vagrant/rpm/mongo/4.2.3 mongodb-org-4.2.3 mongodb-org-server-4.2.3 mongodb-org-shell-4.2.3 mongodb-org-mongos-4.2.3 mongodb-org-tools-4.2.3
yum -y localinstall /vagrant/rpm/mongo/4.2.3/*.rpm

# 强制调整配置文件
\cp /vagrant/conf/mongod.conf /etc/mongod.conf

# echo 'disable selinux'
# setenforce 0
# sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

systemctl enable --now mongod