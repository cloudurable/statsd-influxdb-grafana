#!/usr/bin/env bash
set -e



cd /root/resources

wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

rpm -ivh mysql57-community-release-el7-11.noarch.rpm

yum install -y mysql-server

echo "=> Starting MySQL ..."

export MYSQL_GRAFANA_USER=grafana
export MYSQL_GRAFANA_PW=grafana
export MYSQL_ROOT_PW=grafana
export MYSQL_DATA=/opt/mysql/data
export MYSQL_LOGS=/opt/mysql/logs

echo "Creating directories"
mkdir -p "${MYSQL_DATA}"
mkdir -p "${MYSQL_LOGS}"

echo "Creating DB"
echo "bind-address=0.0.0.0" >> /etc/my.cnf
/usr/sbin/mysqld --initialize --datadir="${MYSQL_DATA}" --user=mysql

echo "Creating Password"
/usr/sbin/mysqld --server-id=2 --skip-grant-tables --datadir="${MYSQL_DATA}" --socket="/var/lib/mysql/mysql.sock" --user=mysql  >"${MYSQL_LOGS}/mysql.log" 2>&1 &


sleep 5

echo "Creating Password for root"
echo "FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PW}';"  | mysql --default-character-set=utf8


sleep 5
echo "Creating user"
echo "CREATE DATABASE grafana" | mysql --default-character-set=utf8 -p"${MYSQL_ROOT_PW}"
echo "CREATE USER '${MYSQL_GRAFANA_USER}' IDENTIFIED BY '${MYSQL_GRAFANA_PW}'" | mysql --default-character-set=utf8 -p"${MYSQL_ROOT_PW}"
echo "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_GRAFANA_USER}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql --default-character-set=utf8 -p"${MYSQL_ROOT_PW}"

echo "=> Stopping MySQL ..."
/usr/bin/mysqladmin stop   -p"${MYSQL_ROOT_PW}"

