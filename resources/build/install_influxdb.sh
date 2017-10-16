#!/bin/bash
set -e
export INFLUXDB_VERSION=1.3.6

wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}.x86_64.rpm
yum  -y localinstall influxdb-${INFLUXDB_VERSION}.x86_64.rpm

cd /root/resources

cp influxdb/influxdb.conf /etc/influxdb/influxdb.conf
cp influxdb/init.sh /etc/init.d/influxdb
