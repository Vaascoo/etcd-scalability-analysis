#!/bin/bash

export NODE1=192.168.1.21
export DATA_DIR="etcd-data"
export REGISTRY=gcr.io/etcd-development/etcd 
export VERSION="v3.5.9"  #because 'latest' wasn't working

# Create volume if doesn't exist
VOLUME=$(docker volume ls -f name=etcd-data)
if [ -z "$VOLUME" ];
then
    docker volume create --name etcd-data
else
    echo "volume already exists"
fi

# Remove previous container 
docker rm etcd

# Run single etcd node
docker run -d \
  -p 2379:2379 \
  -p 2380:2380 \
  --volume=${DATA_DIR}:/etcd-data \
  --name etcd ${REGISTRY}:${VERSION} \
  /usr/local/bin/etcd \
  --data-dir=/etcd-data --name node1 \
  --initial-advertise-peer-urls http://${NODE1}:2380 --listen-peer-urls http://0.0.0.0:2380 \
  --advertise-client-urls http://${NODE1}:2379 --listen-client-urls http://0.0.0.0:2379 \
  --initial-cluster node1=http://${NODE1}:2380
