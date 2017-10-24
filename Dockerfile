FROM cloudurable/statsd-influxdb-grafana:0.4
MAINTAINER Rick Hightower <richardhightower@gmail.com>


ENTRYPOINT ["/usr/bin/supervisord"]


