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
vagrant up

# 停止
vagrant halt
```

## 初始化

- 配置数据源
- 配置dashboard
