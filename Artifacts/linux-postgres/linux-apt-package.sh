#!/bin/bash
mkdir –p /var/databases/pgsql-9.6/data
sudo yum -y localinstall https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum -y update
sudo yum install -y postgresql96 postgresql96-server postgresql96-libs postgresql96-contrib postgresql96-devel
sudo chown –R postgres:postgres /var/databases/pgsql-9.6
su – postgres –c ‘/usr/pgsql-9.6/bin/initdb –D /var/databases/pgsql-9.6/data’

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/private/localhost.key -out /etc/ssl/certs/localhost.crt
cp /etc/pki/tls/certs/localhost.crt /var/databases/pgsql-9.6/data/server.crt
cp /etc/pki/tls/private/localhost.key /var/databases/pgsql-9.6/data/server.key
echo –e “.include /usr/lib/systemd/system/postgresql-96.service\n\n[Service]\nEnvironment=PGDATA=/var/databases/pgsql-9.6/data/\n” > /etc/systemd/system/postgresql-9.6.service
sed -i -e"s/^#listen_addresses = 'localhost'.*$/listen_addresses = '*'/" /var/databases/pgsql-9.6/data/postgresql.conf
sed -i -e"s/^ssl = off.*$/ssl = on/" /var/databases/pgsql-9.6/data/postgresql.conf

sudo systemctl enable postgresql-9.6
sudo systemctl start postgresql-9.6
