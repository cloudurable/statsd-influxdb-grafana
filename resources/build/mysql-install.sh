#!/usr/bin/env bash
set -e

export MYSQL_GRAFANA_USER=grafana
export MYSQL_GRAFANA_PW=grafana

cd /root/resources

wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

rpm -ivh mysql57-community-release-el7-11.noarch.rpm

yum install -y mysql-server

echo "=> Starting MySQL ..."

#RUN echo "bind-address=0.0.0.0" >> /etc/my.cnf
/usr/sbin/mysqld --initialize --datadir="/var/lib/mysql" --user=mysql
/usr/sbin/mysqld --datadir="/var/lib/mysql" --socket="/var/lib/mysql/mysql.sock" --user=mysql  >/dev/null 2>&1 &
/usr/bin/mysqladmin -u root -p password ${MYSQL_GRAFANA_PW}

sleep 5

echo "Creating user"
echo "CREATE DATABASE grafana" | mysql --default-character-set=utf8
echo "CREATE USER '${MYSQL_GRAFANA_USER}' IDENTIFIED BY '${MYSQL_GRAFANA_PW}'" | mysql --default-character-set=utf8
echo "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_GRAFANA_USER}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql --default-character-set=utf8

echo "=> Stopping MySQL ..."
pkill mysqld

