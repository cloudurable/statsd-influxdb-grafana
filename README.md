# Docker Image with Telegraf (StatsD), InfluxDB and Grafana


This project is forked from [docker-statsd-influxdb-grafana](https://github.com/samuelebistoletti/docker-statsd-influxdb-grafana).

For our needs we need MySQL to be hosted by RDS.
We need Centos instead of Ubuntu (client requirements).
And we prefer to use packer instead of Dockerfile to create the image (personal preference and so we can deploy direct to AWS if needed without).
We also want to make data directories settable via ENV variables so we can mount EBS volumes that we can detach and attach to host that is hosting Docker Host.

## Status of the above changes
Not started.
We imported changes from advantageous and docker-statsd-influxdb-grafana.



## Versions

### Warning, breaking change: upgrade from version 1.0.x of this image is not supported, all persisted data in volumes will be lost if you delete the container.

* Docker Image:      2.0.0
* Ubuntu:            16.04
* InfluxDB:          1.2
* Telegraf (StatsD): 1.2
* Grafana:           4.1.1

## Quick Start

To start the container the first time launch:

```sh
docker run -d \
  --name docker-statsd-influxdb-grafana \
  -p 3003:3003 \
  -p 3004:8083 \
  -p 8086:8086 \
  -p 22022:22 \
  -p 8125:8125/udp \
  advantageous/grafana:latest:latest
```

You can replace `latest` with the desired version listed in changelog file.

To stop the container launch:

```sh
docker stop grafana
```

To start the container again launch:

```sh
docker start grafana
```

## Mapped Ports

```
Host		Container		Service

3003		3003			grafana
3004		8083			influxdb-admin
8086		8086			influxdb
8125		8125			statsd
22022		22				sshd
```
## SSH

```sh
ssh root@localhost -p 22022
```
Password: root

## Grafana

Open <http://localhost:3003>

```
Username: root
Password: root
```

### Add data source on Grafana

1. Using the wizard click on `Add data source`
2. Choose a `name` for the source and flag it as `Default`
3. Choose `InfluxDB` as `type`
4. Choose `direct` as `access`
5. Fill remaining fields as follows and click on `Add` without altering other fields

```
Url: http://localhost:8086
Database:	telegraf
User: telegraf
Password:	telegraf
```

Basic auth and credentials must be left unflagged. Proxy is not required.

Now you are ready to add your first dashboard and launch some query on database.

## InfluxDB

### Web Interface

Open <http://localhost:3004>

```
Username: root
Password: root
Port: 8086
```

### InfluxDB Shell (CLI)

1. Establish a ssh connection with the container
2. Launch `influx` to open InfluxDB Shell (CLI)

## Build

```
docker build -t advantageous/grafana:v1   .
docker build -t advantageous/grafana:latest  .
```

## Push
```
docker push  advantageous/grafana
```
