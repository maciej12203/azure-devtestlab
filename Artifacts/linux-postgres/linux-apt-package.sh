#!/bin/bash
sudo rpm -ivh https://yum.postgresql.org/9.6/redhat/rhel-7.3-x86_64/pgdg-centos96-9.6-3.noarch.rpm
sudo yum -y update
sudo yum install -y postgresql96 postgresql96-server postgresql96-libs postgresql96-contrib postgresql96-devel
sudo sed -i -e"s/^#listen_addresses = 'localhost'.*$/listen_addresses = '*'/" /usr/pgsql-9.6/share/postgresql.conf.sample
sudo sed -i -e"s/^#port = 5432.*$/port = 5432/" /usr/pgsql-9.6/share/postgresql.conf.sample
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
sudo systemctl enable postgresql-9.6
sudo systemctl start postgresql-9.6
