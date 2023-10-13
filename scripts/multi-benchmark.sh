#!/usr/bin/env bash

CLUSTER_SIZE=$1
ENDPOINTS=$(./generate-docker-compose.sh "$CLUSTER_SIZE" | tail -n 1)
PATH=$PATH:~/go/bin

echo "Running benchmark with the following nodes: $ENDPOINTS"

# start etcd cluster
if [[ $(hostname) != "chord" ]]; then
  sudo docker compose up -d
else
  docker compose up -d
fi


while true; do
  if [[ $(etcdctl --endpoints="$ENDPOINTS" endpoint health |& grep -c "unhealthy") == 0 ]]; then
      echo "health check passed"
      break
  fi
  echo "health check failed, sleeping 2 seconds"
  sleep 2
done

etcdctl --endpoints="$ENDPOINTS" endpoint health

# run benchmark
COMMAND="benchmark --endpoints=$ENDPOINTS --clients=1000 --conns=100 txn-mixed --key-size=256 --total=500000"
echo "$COMMAND" > "benchmark-output/$CLUSTER_SIZE.txt"
$COMMAND

# shutdown etcd cluster
echo "Benchmark finished, shutting down etcd cluster..."
if [[ $(hostname) != "chord" ]]; then
  sudo docker compose down
else
  docker compose down
fi
