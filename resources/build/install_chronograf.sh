#!/bin/bash
set -e
export CHRONOGRAF_VERSION=1.3.9.0


wget https://dl.influxdata.com/chronograf/releases/chronograf-${CHRONOGRAF_VERSION}.x86_64.rpm
yum -y localinstall chronograf-${CHRONOGRAF_VERSION}.x86_64.rpm