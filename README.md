# bp-virtualbox

## 制作基础镜像

```shell
wget -c http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-2002_01.VirtualBox.box

vagrant box add CentOS-7-x86_64-Vagrant-2002_01.VirtualBox.box --name centos/7-2002_01
vagrant box list

# 更新box
cd vms/base/centos/7-2002_01
vagrant init centos/7-2002_01
vagrant up
vagrant ssh

$ sudo -i
$ yum -y update

$ exit
$ exit

vagrant package --output CentOS-7-x86_64-Vagrant-2002_01-20200512.VirtualBox.box

vagrant box add CentOS-7-x86_64-Vagrant-2002_01-20200512.VirtualBox.box --name centos/7-2002_01-20200512
vagrant box list
```

