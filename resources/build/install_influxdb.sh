#!/bin/bash
set -e
export INFLUXDB_VERSION=1.3.6

wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}.x86_64.rpm
yum  -y localinstall influxdb-${INFLUXDB_VERSION}.x86_64.rpm

cd /root/resources

cp /root/resources/influxdb/influxdb.conf /etc/influxdb/influxdb.conf
cp /root/resources/influxdb/init.sh /etc/rc.d/init.d/influxdb
chmod +x /etc/rc.d/init.d/influxdb