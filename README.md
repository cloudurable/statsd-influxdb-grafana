# Docker Image with Telegraf (StatsD), InfluxDB and Grafana


We made this a modular example that is easy to fork and change so if you are setting up the TICK stack, you can prototype quickly.


## Source code

The source code for this project can be found [Source code](https://github.com/cloudurable/statsd-influxdb-grafana).

## Docker hub


## Status of the above changes
We updated to the latest versions of InfluxDB, Telegraf, Grafana and Chronograf circa October 2017.

```
CHRONOGRAF_VERSION=1.3.9.0
GRAFANA_VERSION=4.5.2
INFLUXDB_VERSION=1.3.6
TELEGRAF_VERSION=1.4.2
```

Chronograf takes the place of the old InfluxDB Admin.
Chronograf can take on a lot of tasks that Grafana gets used for.
Telegraf is what we use to adapt InfluxDB to STATSD.



## Quick Start

To start the container the first time launch:

```sh
docker run --name grafana \
  -p 3003:3003 \
  -p 8083:8083 \
  -p 8086:8086 \
  -p 22022:22 \
  -p 8125:8125/udp \
  cloudurable/statsd-influxdb-grafana:latest \
  /usr/bin/supervisord
```

You can replace `latest` with the desired version.

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
8083		8083			chronograf
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
Password: grafana
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

### Web Admin Interface

Open <http://localhost:8083>

```
Username: root
Password: root
Port: 8086
```

## Forked


This project is forked from [docker-statsd-influxdb-grafana](https://github.com/samuelebistoletti/docker-statsd-influxdb-grafana) which seemed to be stuck a few versions back.

For our needs we need MySQL to be hosted by RDS.
We need Centos instead of Ubuntu (client requirements).
And we prefer to use packer instead of Dockerfile to create the image (personal preference and so we can deploy direct to AWS if needed without).
We also want to make data directories settable via ENV variables so we can mount EBS volumes that we can detach and attach to host that is hosting Docker Host.
And last but not least, we want to use the latest versions.


### InfluxDB Shell (CLI)

1. Establish a ssh connection with the container
2. Launch `influx` to open InfluxDB Shell (CLI)

## Build with docker

```
docker build -t cloudurable/grafana:v1   .
docker build -t cloudurable/grafana:latest  .
```


## Build with packer

```
packer build packer.json
```

## Push
```
docker push  cloudurable/grafana
```


## Developer  Notes
## Run and debug

```
docker run -i -t cloudurable/statsd-influxdb-grafana:0.1  /bin/bash
```

## Attach

```
docker exec -it  424761df905b  bash

```

## Ports

```
netstat -plnt
```

## Clean up old images
```
docker images | grep none | awk '{print $3}' | xargs docker rmi
```

## Clean up old containers
```
docker ps -a  | awk '{print $1}' | xargs docker stop
docker ps -a  | grep Exited | awk '{print $1}' | xargs docker rm
```

## About us


Cloudurable&trade; provides:

* [Subscription Cassandra Database support](http://cloudurable.com/subscription_support_benefits_cassandra/index.html) ([Support subscription pricing for Cassandra and Kafka](http://cloudurable.com/subscription_support/index.html)).
* [Quickstart Mentoring Consulting](http://cloudurable.com/service-quick-start-mentoring-cassandra-or-kafka-aws-ec2/index.html)
* [Architectural Analysis Consulting](http://cloudurable.com/service-architecture-analysis-cassandra-or-kafka-aws-ec2/index.html)
* [Training and mentoring for Cassandra for DevOps and Developers](http://cloudurable.com/training/index.html)
* [Training and mentoring for Kafka for DevOps and Developers](http://cloudurable.com/kafka-training/index.html "Apache Kafka Training Course, Instructor led, onsite training")