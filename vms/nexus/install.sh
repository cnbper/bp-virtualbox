#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

# Linux增加打开文件/文件描述符的最大数量（FD）
cat << EOF >> /etc/security/limits.conf
root soft nofile 65536
root hard nofile 65536
EOF

# 安装Java 8 Runtime Environment (JRE)
rpm -ivh /vagrant/downloads/jre-8u281-linux-x64.rpm

# 下载安装包 https://download.sonatype.com/nexus/3/latest-unix.tar.gz
cd /opt && tar zxf /vagrant/downloads/nexus-3.29.2-02-unix.tar.gz

mv nexus-3.29.2-02 nexus

useradd --system --create-home nexus
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /opt/sonatype-work

cat << EOF > /opt/nexus/bin/nexus.vmoptions
-Xms640m
-Xmx640m
-XX:MaxDirectMemorySize=640m
-XX:+UnlockDiagnosticVMOptions
-XX:+LogVMOutput
-XX:LogFile=../sonatype-work/nexus3/log/jvm.log
-XX:-OmitStackTraceInFastThrow
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=etc/karaf/java.util.logging.properties
-Dkaraf.data=../sonatype-work/nexus3
-Dkaraf.log=../sonatype-work/nexus3/log
-Djava.io.tmpdir=../sonatype-work/nexus3/tmp
-Dkaraf.startLocalConsole=false

-Djava.endorsed.dirs=lib/endorsed

-Djava.util.prefs.userRoot=/home/nexus/.java
EOF

cat << EOF > /opt/nexus/bin/nexus.rc
run_as_user="nexus"
EOF

# 配置自启动
cat > /etc/systemd/system/nexus.service << EOF
[Unit]
Description=nexus service
After=syslog.target network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Group=nexus
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service

# tail -f /opt/sonatype-work/nexus3/log/nexus.log
# netstat -tunlp | grep 8081