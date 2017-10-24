#!/bin/bash
set -e


export LANG=C.UTF-8

# Default versions


export GRAFANA_VERSION=4.1.1-1484211277

# Database Defaults
export INFLUXDB_GRAFANA_DB=datasource
export INFLUXDB_GRAFANA_USER=datasource
export INFLUXDB_GRAFANA_PW=datasource

export MYSQL_GRAFANA_USER=grafana
export MYSQL_GRAFANA_PW=grafana

yum install -y epel-release
yum update -y
yum install -y wget

yum install -y  mysql
yum install -y  nano
yum install -y  net-tools
yum install -y  openssh-server openssh-clients
yum install -y which
yum install -y htop
yum install -y nodejs
yum -y install python-pip
pip install --upgrade pip
pip install supervisor


cd /root/resources/
mkdir -p /etc/supervisor/conf.d/
cp supervisord/supervisord.conf /etc/supervisor/supervisord.conf

mkdir -p /var/log/supervisor
mkdir -p /var/run/sshd


sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
echo 'root:root' | chpasswd

cd /root
rm -rf .ssh
rm -rf .profile
mkdir .ssh

cd /root/resources/

echo "setting up ssl"
cp ssh/id_rsa /root/.ssh/id_rsa
/usr/bin/ssh-keygen -A

/root/resources/build/mysql_install.sh
/root/resources/build/install_telegraf.sh
/root/resources/build/install_grafana.sh
/root/resources/build/install_chronograf.sh
/root/resources/build/install_influxdb.sh

rm -rf /root/resources/



