#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

yum -y install unzip

mkdir -p /opt/monitor && cd /opt/monitor

# http://172.17.8.153:9100/metrics
tar zxf  /vagrant/downloads/node_exporter-0.18.1.linux-amd64.tar.gz
mv node_exporter-0.18.1.linux-amd64 node_exporter

cat << EOF >> /lib/systemd/system/node_exporter.service
[Unit]
Description=Prometheus node_exporter
Documentation=https://prometheus.io/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/opt/monitor/node_exporter/node_exporter
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable node_exporter.service && systemctl start node_exporter.service

# http://172.17.8.153:9090/graph
tar zxf /vagrant/downloads/prometheus-2.13.1.linux-amd64.tar.gz
mv prometheus-2.13.1.linux-amd64 prometheus

cat << EOF >> /lib/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
# --storage.tsdb.path是可选项，默认数据目录在运行目录的./dada目录中
ExecStart=/opt/monitor/prometheus/prometheus --config.file=/vagrant/conf/prometheus/prometheus.yml --storage.tsdb.path=/vagrant/temp/prometheus
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable prometheus.service && systemctl start prometheus.service

# http://172.17.8.153:3000 admin/admin
tar zxf /vagrant/downloads/grafana-6.4.3.linux-amd64.tar.gz

unzip /vagrant/downloads/grafana-piechart-panel.zip
mv grafana-piechart-panel-* /vagrant/temp/grafana/plugins/grafana-piechart-panel

# https://github.com/grafana/grafana/blob/v6.4.3/packaging/deb/systemd/grafana-server.service
cat << EOF >> /lib/systemd/system/grafana-server.service
[Unit]
Description=Grafana
Documentation=http://docs.grafana.org
Wants=network-online.target
After=network-online.target
After=postgresql.service mariadb.service mysql.service

[Service]
Type=simple
WorkingDirectory=/opt/monitor/grafana-6.4.3
ExecStart=/opt/monitor/grafana-6.4.3/bin/grafana-server \
                            --config=/vagrant/conf/grafana/custom.ini
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable grafana-server.service && systemctl start grafana-server.service
