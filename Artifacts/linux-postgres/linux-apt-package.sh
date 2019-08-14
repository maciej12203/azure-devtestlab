#!/bin/bash
mkdir –p /var/databases/pgsql-9.2/data
yum install postgresql-server -y
yum install postgresql-contrib -y
sudo chown –R postgres:postgres /var/databases/pgsql-9.2

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/private/localhost.key -out /etc/ssl/certs/localhost.crt
cp /etc/pki/tls/certs/localhost.crt /var/databases/pgsql-9.2/data/server.crt
cp /etc/pki/tls/private/localhost.key /var/databases/pgsql-9.2/data/server.key
echo –e “.include /usr/lib/systemd/system/postgresql.service\n\n[Service]\nEnvironment=PGDATA=/var/databases/pgsql-9.2/data/\n” > /etc/systemd/system/postgresql.service
sed -i -e"s/^#listen_addresses = 'localhost'.*$/listen_addresses = '*'/" /var/databases/pgsql-9.2/data/postgresql.conf
sed -i -e"s/^#ssl = off.*$/ssl = on/" /var/databases/pgsql-9.2/data/postgresql.conf
su – postgres –c ‘initdb –D /var/databases/pgsql-9.2/data’

sudo systemctl enable postgresql
sudo systemctl start postgresql
