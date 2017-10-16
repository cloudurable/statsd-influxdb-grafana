#!/usr/bin/env bash

export GRAFANA_VERSION=4.5.2

# Install Grafana
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-${GRAFANA_VERSION}-1.x86_64.rpm
yum -y localinstall grafana-${GRAFANA_VERSION}-1.x86_64.rpm

# Configure Grafana
cp grafana/grafana.ini /etc/grafana/grafana.ini