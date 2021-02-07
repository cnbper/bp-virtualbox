# postgresql

<https://www.postgresql.org/download/linux/redhat/#yum>

```shell
yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

yum install postgresql11

yum install postgresql11-server
```

```shell
/usr/pgsql-11/bin/postgresql-11-setup initdb
systemctl enable postgresql-11
systemctl start postgresql-11
```
