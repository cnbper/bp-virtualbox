#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

echo 'disable selinux'
setenforce 0
sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

sed -i 's/127.0.0.1/172.17.8.154/g' /etc/hosts

# yum -y install --downloadonly --downloaddir=/vagrant/downloads/epel-release epel-release
yum localinstall -y /vagrant/downloads/epel-release/*.rpm

# yum -y install --downloadonly --downloaddir=/vagrant/downloads/tools yum-plugin-priorities python2-pip 
yum localinstall -y /vagrant/downloads/tools/*.rpm

# 安装 ceph-deploy
# yum -y install --downloadonly --downloaddir=/vagrant/downloads/ceph-deploy ceph-deploy 
yum localinstall -y /vagrant/downloads/ceph-deploy/*.rpm

# 安装 ceph
# https://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-install/
# ceph-deploy install --release nautilus cnbper-ceph
# yum -y install --downloadonly --downloaddir=/vagrant/downloads/ceph ceph ceph-release ceph-radosgw
yum localinstall -y /vagrant/downloads/ceph/*.rpm
