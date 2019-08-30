#!/bin/bash
set -e
set -x

echo "Starting etcd-registrar..."
etcd-registrar \
    --loglevel=$LOG_LEVEL \
    --etcd-url=$ETCD_URL \
    --etcd-base=$ETCD_BASE \
    --service=$SERVICE \
    --port=$PORT \
    --info=$INFO \
    --ttl=$TTL \
    --list=$LIST

