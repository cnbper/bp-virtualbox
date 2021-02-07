#!/usr/bin/env bash

# yum -y update --downloadonly --downloaddir=/vagrant/rpm/base
# yum localinstall -y /vagrant/rpm/base/*.rpm

# 安装 epel-release
# yum -y install --downloadonly --downloaddir=/vagrant/rpm/epel-release epel-release
yum localinstall -y /vagrant/rpm/epel-release/*.rpm

# 安装python
# yum -y install --downloadonly --downloaddir=/vagrant/rpm/python python git python-pip
yum localinstall -y /vagrant/rpm/python/*.rpm

# pip安装ansible(国内如果安装太慢可以直接用pip阿里云加速)
# pip download pip -i https://mirrors.aliyun.com/pypi/simple/ -d /vagrant/pypi/pip
pip install /vagrant/pypi/pip/pip-20.1-py2.py3-none-any.whl
# pip download ansible==2.6.18 netaddr==0.7.19 -i https://mirrors.aliyun.com/pypi/simple/ -d /vagrant/pypi/ansible
pip install --no-index --find-links=/vagrant/pypi/ansible ansible==2.6.18 netaddr==0.7.19

echo 'set host name resolution'
cat >> /etc/hosts <<EOF
172.17.8.101 kube-master
172.17.8.102 kube-node1
172.17.8.103 kube-node2
192.168.110.200 registry.sloth.com
EOF
cat /etc/hosts

echo "copy harbor files"
mkdir -p /etc/docker/certs.d/registry.sloth.com
cp /vagrant/conf/harbor/registry.sloth.com/registry.sloth.com.crt /etc/docker/certs.d/registry.sloth.com/registry.sloth.com.crt

if [[ $1 -eq 1 ]]
then
    echo "configure kube-master"
    ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa
    
    mkdir -p /vagrant/temp/linux/
    cat /root/.ssh/id_rsa.pub > /vagrant/temp/linux/authorized_keys

    # 配置ansible控制端免密码登录
    mkdir -p /root/.ssh
    cat /vagrant/temp/linux/authorized_keys >> /root/.ssh/authorized_keys

    # 在ansible控制端编排k8s安装
    ## 下载项目源码，安装docker
    ## ./easzup -D
    ## cp -r /etc/ansible/* /vagrant/tools/ansible/
    mkdir -p /etc/ansible
    cp -r /vagrant/tools/ansible/* /etc/ansible
    # 离线安装 docker，检查本地文件，正常会提示所有文件已经下载完成
    /vagrant/tools/easzup -D
fi

if [[ $1 -eq 2 ]]
then
    echo "configure kube-node1"
    # 配置ansible控制端免密码登录
    mkdir -p /root/.ssh
    cat /vagrant/temp/linux/authorized_keys >> /root/.ssh/authorized_keys
fi

if [[ $1 -eq 3 ]]
then
    echo "configure kube-node2"
    # 配置ansible控制端免密码登录
    mkdir -p /root/.ssh
    cat /vagrant/temp/linux/authorized_keys >> /root/.ssh/authorized_keys
fi