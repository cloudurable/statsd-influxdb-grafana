#!/bin/bash
set -e
export INFLUXDB_VERSION=1.3.6

wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}.x86_64.rpm
sudo yum localinstall influxdb-${INFLUXDB_VERSION}.x86_64.rpm
