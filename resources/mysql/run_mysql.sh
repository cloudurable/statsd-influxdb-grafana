#!/usr/bin/env bash
export MYSQL_DATA=/opt/mysql/data
export MYSQL_LOGS=/opt/mysql/logs

/usr/sbin/mysqld --server-id=2 --datadir="${MYSQL_DATA}" \
--socket="/var/lib/mysql/mysql.sock" --user=mysql  \
>"${MYSQL_LOGS}/mysql.log" 2>&1 &
sleep 5