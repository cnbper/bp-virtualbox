# monitor vms

## 参考文档

- <https://prometheus.io/docs/prometheus/latest/installation/>

## 安装包准备

- 下载以下安装包并放到downloads文件夹

```shell
wget https://github.com/prometheus/prometheus/releases/download/v2.13.1/prometheus-2.13.1.linux-amd64.tar.gz
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
wget https://github.com/prometheus/alertmanager/releases/download/v0.19.0/alertmanager-0.19.0.linux-amd64.tar.gz
wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.12.1/mysqld_exporter-0.12.1.linux-amd64.tar.gz

wget https://dl.grafana.com/oss/release/grafana-6.4.3.linux-amd64.tar.gz
wget -nv https://grafana.com/api/plugins/grafana-piechart-panel/versions/latest/download -O grafana-piechart-panel.zip

https://grafana.com/grafana/dashboards/10262
```

## 启动

```shell
mkdir -p temp/grafana/plugins
mkdir -p temp/prometheus

vagrant up

# 停止
vagrant halt
```

## 测试

- <http://172.17.8.153:9100/metrics>
- <http://172.17.8.153:9090/graph>
- <http://172.17.8.153: 3000> admin/admin

## 初始化

- 配置 Prometheus 数据源 : <http://172.17.8.153:9090>
- 配置 node dashboard : conf/grafana/dashboards

## prometheus 常见操作

```shell
# 重新加载配置
vi /vagrant/conf/prometheus/prometheus.yml

# 第一种，向prometheus进行发信号
kill -HUP pid

# 第二种，向prometheus发送HTTP请求
# /-/reload只接收POST请求，并且需要在启动prometheus进程时，指定 --web.enable-lifecycle
curl -XPOST http://prometheus.chenlei.com/-/reload
```
