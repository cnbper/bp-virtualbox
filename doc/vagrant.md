# Vagrant

## vagrant box

- centos-7 <http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1905_01.VirtualBox.box>

```shell
vagrant box add CentOS-7-x86_64-Vagrant-1905_01.VirtualBox.box --name centos/7

vagrant box list
```

## vagrant init

此命令用于生成Vagrantfile文件：

```shell
vagrant init

vagrant init centos/7
```

### 网络配置

- 端口映射

```shell
config.vm.network "forwarded_port", guest: 80, host: 8080
config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
```

- private_network

```shell
config.vm.network "private_network", ip: "192.168.33.10"
```

- public_network

```shell
config.vm.network "public_network"
```

### 目录映射

```shell
config.vm.synced_folder "../data", "/vagrant_data"
# nfs共享
config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
```

### VM提供者配置

```shell
config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
  vb.gui = true

  # Customize the amount of memory on the VM:
  vb.memory = "1024"
end
```

- 同步宿主机时间

```shell
config.vm.provider 'virtualbox' do |vb|
  vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
end
```

### 其他配置

配置 | 默认值 | 说明
- | - | -
config.vm.box_check_update | false | false: 不检查更新

## 日常操作

- 安装/启动

```shell
vagrant up
```

- 停止

```shell
vagrant halt
```

- 卸载

```shell
vagrant destroy
rm -rf .vagrant
```
