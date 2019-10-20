#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

rm /etc/yum.repos.d/CentOS-Base.repo
cp /vagrant/yum/*.* /etc/yum.repos.d/
mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

mkdir -p /opt/nginx && cd /opt/nginx

yum -y install cmake ncurses-devel bison make gcc gcc-c++ perl

tar zxf /vagrant/downloads/openssl-1.1.1d.tar.gz
tar jxf /vagrant/downloads/pcre-8.43.tar.bz2
tar zxf /vagrant/downloads/zlib-1.2.11.tar.gz
tar zxf /vagrant/downloads/nginx-1.16.1.tar.gz && cd nginx-1.16.1

# 添加TCP反向代理支持
# 添加HTTP2支持 
./configure --prefix=/opt/nginx/nginx --with-pcre=../pcre-8.43 --with-zlib=../zlib-1.2.11 \
    --with-openssl=../openssl-1.1.1d --with-http_gzip_static_module \
    --with-http_stub_status_module --with-http_ssl_module \
    --with-stream \
    --with-http_v2_module

make && make install

cat << EOF >> /lib/systemd/system/nginx.service
[Unit] 
Description=nginx 
After=network.target 
 
[Service] 
Type=forking 
ExecStart=/opt/nginx/nginx/sbin/nginx 
ExecReload=/opt/nginx/nginx/sbin/nginx -s reload 
ExecStop=/opt/nginx/nginx/sbin/nginx -s quit
PrivateTmp=true 
 
[Install] 
WantedBy=multi-user.target
EOF

systemctl enable nginx.service && systemctl start nginx.service
