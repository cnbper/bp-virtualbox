# kubernetes vms

## 参考文档

- <https://github.com/easzlab/kubeasz/blob/master/docs/setup/quickStart.md>
- <https://github.com/easzlab/kubeasz/blob/master/docs/setup/offline_install.md>

```shell
#选择2.1.0版本的easzup，2.1.0版本的easzup默认安装的kubernetes版本为1.16.2
export release=2.1.0
curl -C- -fLO --retry 3 https://github.com/easzlab/kubeasz/releases/download/${release}/easzup


# 修改配置
vi tools/ansible/roles/cluster-addon/defaults/main.yml
# ************************************************************
#不安装dashboard,rainbond不依赖dashboard
dashboard_install: "no"
#不安装ingress，rainbond自带ingress网关
ingress_install: "no"
# ************************************************************

# 多网卡修改
vi tools/ansible/roles/flannel/templates/kube-flannel.yaml.j2
# ************************************************************
- --iface=eth1
# ************************************************************
```

```shell
vagrant ssh kube-master
sudo -i

# cp tools/ansible/example/hosts.multi-node conf/hosts.multi-node
cd /etc/ansible && cp /vagrant/conf/hosts.multi-node hosts

# 测试
ansible all -m ping

# 设置参数，启用离线安装
sed -i 's/^INSTALL_SOURCE.*$/INSTALL_SOURCE: "offline"/g' /etc/ansible/roles/chrony/defaults/main.yml
sed -i 's/^INSTALL_SOURCE.*$/INSTALL_SOURCE: "offline"/g' /etc/ansible/roles/ex-lb/defaults/main.yml
sed -i 's/^INSTALL_SOURCE.*$/INSTALL_SOURCE: "offline"/g' /etc/ansible/roles/kube-node/defaults/main.yml
sed -i 's/^INSTALL_SOURCE.*$/INSTALL_SOURCE: "offline"/g' /etc/ansible/roles/prepare/defaults/main.yml

# 分步安装
# ansible-playbook 01.prepare.yml
# ansible-playbook 02.etcd.yml
# ansible-playbook 03.docker.yml
# ansible-playbook 04.kube-master.yml
# ansible-playbook 05.kube-node.yml
# ansible-playbook 06.network.yml
# ansible-playbook 07.cluster-addon.yml
# 一步安装
ansible-playbook 90.setup.yml


# 保存配置文件
rm -rf /vagrant/temp/kubernetes/config
cp -i /root/.kube/config /vagrant/temp/kubernetes/config


# 访问外网？？？ DNS服务发现

# etcd https://github.com/easzlab/kubeasz/blob/master/docs/setup/02-install_etcd.md
--endpoints=https://${ip}:2379  \
  --cacert=/etc/kubernetes/ssl/ca.pem \
  --cert=/etc/etcd/ssl/etcd.pem \
  --key=/etc/etcd/ssl/etcd-key.pem \
```

```shell
rm -rf ~/.kube && mkdir -p ~/.kube
cp temp/kubernetes/config ~/.kube/config
kubectl get nodes
```
