#!/bin/bash
#mkdir –p /var/databases/pgsql-9.6/data
wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
sudo yum install pgdg-centos96-9.6-3.noarch.rpm epel-release
sudo yum update
sudo yum install postgresql96-server postgresql96-contrib
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
sudo systemctl start postgresql-9.6
sudo systemctl enable postgresql-9.6
#yum install  https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm -y
#yum install postgresql96 postgresql96-server postgresql96-contrib postgresql96-libs -y
#sudo chown –R postgres:postgres /var/databases/pgsql-9.6

#openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/private/localhost.key -out /etc/ssl/certs/localhost.crt
#cp /etc/pki/tls/certs/localhost.crt /var/databases/pgsql-9.2/data/server.crt
#cp /etc/pki/tls/private/localhost.key /var/databases/pgsql-9.2/data/server.key
#echo –e “.include /usr/lib/systemd/system/postgresql.service\n\n[Service]\nEnvironment=PGDATA=/var/databases/pgsql-9.6/data/\n” > /etc/systemd/system/postgresql-9.6.service
#sed -i -e"s/^#listen_addresses = 'localhost'.*$/listen_addresses = '*'/" /var/databases/pgsql-9.6/data/postgresql.conf
#sed -i -e"s/^#ssl = off.*$/ssl = on/" /var/databases/pgsql-9.6/data/postgresql.conf
#su – postgres –c ‘initdb –D /var/databases/pgsql-9.6/data’

#systemctl enable postgresql-9.6.service
#systemctl start postgresql-9.6.service
