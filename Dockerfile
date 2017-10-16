FROM cloudurable/statsd-influxdb-grafana:0.1
MAINTAINER Rick Hightower <richardhightower@gmail.com>


ENTRYPOINT ["/usr/bin/supervisord"]

