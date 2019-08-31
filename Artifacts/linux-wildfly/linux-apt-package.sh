#!/bin/bash
wget -e use_proxy=yes -e https_proxy=w3cache.gkjsw.pl:8080 https://download.jboss.org/wildfly/16.0.0.Final/wildfly-16.0.0.Final.tar.gz
sudo groupadd -r wildfly
sudo useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly
wget https://download.jboss.org/wildfly/16.0.0.Final/wildfly-16.0.0.Final.tar.gz -P /tmp
sudo tar xf /tmp/wildfly-16.0.0.Final.tar.gz -C /opt/
mkdir /opt/wildfly
sudo ln -s /opt/wildfly-16.0.0.Final /opt/wildfly/wildfly-16.0.0
sudo chown -RH wildfly: /opt/wildfly
sudo mkdir -p /etc/wildfly
sudo cp /opt/wildfly/wildfly-16.0.0/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/wildfly-16.0.0/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/wildfly-16.0.0/bin/
sudo sh -c 'chmod +x /opt/wildfly/wildfly-16.0.0/bin/*.sh'
sudo cp /opt/wildfly/wildfly-16.0.0/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sed -i -e"s/^WILDFLY_CONFIG=standalone.xml.*$/WILDFLY_CONFIG=domain.xml/" /etc/wildfly/wildfly.conf
sed -i -e"s/^WILDFLY_MODE=standalone.*$/WILDFLY_MODE=domain/" /etc/wildfly/wildfly.conf
sed -i -e"s/^WILDFLY_BIND=0.0.0.0.*$/WILDFLY_BIND=0.0.0.0/" /etc/wildfly/wildfly.conf
sudo systemctl daemon-reload
sudo systemctl start wildfly
sudo systemctl enable wildfly
