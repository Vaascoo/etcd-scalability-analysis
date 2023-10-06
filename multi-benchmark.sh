#!/bin/bash

CLUSTER_SIZE=$1
ENDPOINTS=$(./generate-docker-compose.sh $CLUSTER_SIZE | tail -n 1)

export ENDPOINTS

# start etcd cluster
sudo docker compose up -d


while true; do
    if [[ $(etcdctl --endpoints=$ENDPOINTS endpoint health &| grep "unhealthy" | wc -l) == 0 ]]; then
        echo "health check passed"
        break
    fi
    echo "health check failed, sleeping 2 seconds"
    sleep 2
done

etcdctl --endpoints=$ENDPOINTS endpoint health

sudo docker compose down

exit

# run benchmark
COMMAND="benchmark --endpoints=$ENDPOINTS --clients=100 --conns=1000 txn-mixed --key-size=256 --total=100000"
echo $COMMAND > benchmark-output/$CLUSTER_SIZE.txt
benchmark --endpoints=$ENDPOINTS --clients=100 --conns=1000 txn-mixed --key-size=256 --total=100000 >> benchmark-output/$CLUSTER_SIZE.txt

# shutdown etcd cluster
echo "Benchmark finished, shutting down etcd cluster..."
sudo docker compose down