#!/bin/bash
set -e
export TELEGRAF_VERSION=1.4.2

wget https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-1.x86_64.rpm
sudo yum localinstall telegraf-${TELEGRAF_VERSION}-1.x86_64.rpm

