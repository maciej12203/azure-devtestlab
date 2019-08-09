#!/bin/bash
yum -y makecache
yum -y install lvm2
mkdir –p /var/databases/pgsql-11/data
chown –R postgres:postgres /var/databases/pgsql-11
yum -y localinstall https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum -y install postgresql11 postgresql11-server postgresql11-libs postgresql11-contrib
chown –R postgres:postgres /var/databases/pgsql-11
su – postgres –c ‘/usr/pgsql-11/bin/initdb –D /var/databases/pgsql-11/data’
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/private/localhost.key -out /etc/ssl/certs/localhost.crt
cp /etc/pki/tls/certs/localhost.crt /var/databases/pgsql-11/data/server.crt
cp /etc/pki/tls/private/localhost.key /var/databases/pgsql-11/data/server.key
echo –e “.include /usr/lib/systemd/system/postgresql-11.service\n\n[Service]\nEnvironment=PGDATA=/var/databases/pgsql-11/data/\n” > /etc/systemd/system/postgresql-11.service
sed -i -e"s/^#listen_addresses = 'localhost'.*$/listen_addresses = '*'/" /var/databases/pgsql-11/data/postgresql.conf
sed -i -e"s/^ssl = off.*$/ssl = on/" /var/databases/pgsql-11/data/postgresql.conf
sudo systemctl start postgresql
sudo systemctl enable postgresql
