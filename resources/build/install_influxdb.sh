#!/bin/bash
set -e
export INFLUXDB_VERSION=1.3.6

wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}.x86_64.rpm
yum  -y localinstall influxdb-${INFLUXDB_VERSION}.x86_64.rpm

cd /root/resources

export INFLUX_DATA="\/opt\/influxdb\/data"
export INFLUX_META="\/opt\/influxdb\/meta"
export INFLUX_WAL="\/opt\/influxdb\/wal"


mkdir -p /etc/influxdb/
mkdir -p /opt/influxdb/data
mkdir -p /opt/influxdb/meta
mkdir -p /opt/influxdb/wal

cp /root/resources/influxdb/influxdb.conf /etc/influxdb/influxdb.conf

sed -i "s/  dir = \"\/var\/influxdb\/data\"/  dir = \"${INFLUX_DATA}\"/" /etc/influxdb/influxdb.conf
sed -i "s/  dir = \"\/var\/influxdb\/meta\"/  dir = \"${INFLUX_META}\"/" /etc/influxdb/influxdb.conf
sed -i "s/  wal-dir = \"\/var\/influxdb\/wal\"/  wal-dir = \"${INFLUX_WAL}\"/" /etc/influxdb/influxdb.conf
