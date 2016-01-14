#!/bin/sh

handle_signal() {
  PID=$!
  echo "received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

mkdir -p /config
mkdir -p /data
[ ! -f /config/nzbget.conf ] && cp /usr/share/nzbget/nzbget.conf /config/nzbget.conf


echo "starting nzbget"
exec nzbget -c /config/nzbget.conf -s > /dev/null
echo "stopping nzbget"
