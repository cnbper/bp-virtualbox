# nginx vms

## 参考文档

- <http://nginx.org/en/download.html>
- <http://nginx.org/en/docs/configure.html>
- <https://github.com/openresty/lua-nginx-module>

## 安装包准备

- 下载以下安装包并放到downloads文件夹

```shell
wget http://nginx.org/download/nginx-1.16.1.tar.gz
wget http://zlib.net/zlib-1.2.11.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.bz2
wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz

wget https://www.openssl.org/source/openssl-1.0.2m.tar.gz
```

## 启动

```shell
vagrant up

# 停止
vagrant halt
```
