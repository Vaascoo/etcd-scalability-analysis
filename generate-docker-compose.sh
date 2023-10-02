#!/bin/bash

# TODO: How to not have clashing port numbers

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number_of_workers>"
  exit 1
fi

NUM_WORKERS=$1

CLUSTER=$(for ((j=0; j<$NUM_WORKERS; j++)); do echo -n "etcd-$j=http://esle-worker$j-1.esle_cluster:2380"; if [ $j -lt $(($NUM_WORKERS-1)) ]; then echo -n ","; fi; done)

cat > docker-compose.yml <<EOL
version: '3'
services:
EOL

for ((i=0; i<$NUM_WORKERS; i++)); do
  cat >> docker-compose.yml <<EOL
  worker$i:
    image: gcr.io/etcd-development/etcd:v3.5.9
    command:
      - etcd
      - --name=etcd-$i
      - --data-dir=/etcd-data
      - --initial-advertise-peer-urls=http://esle-worker$i-1.esle_cluster:2380
      - --advertise-client-urls=http://esle-worker$i-1.esle_cluster:2379
      - --listen-client-urls=http://0.0.0.0:2379
      - --listen-peer-urls=http://0.0.0.0:2380
      - --initial-cluster=$CLUSTER
      - --initial-cluster-state=new
      - --initial-cluster-token=etcd-cluster-1
    ports:
      - "$((2379 + $i)):2379"
      - "$((2380 + $i)):2380"
    networks:
      - cluster
EOL
done

cat >> docker-compose.yml <<EOL
networks:
  cluster:
EOL

echo "Docker Compose file generated with $NUM_WORKERS worker(s)."
