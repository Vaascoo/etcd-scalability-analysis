# Etcd Performance and Scalability

The system at study is [etcd](https://etcd.io/).

## Requirements

- [Go version 1.16+](https://go.dev/doc/install)

## Etcd CLI

Before deploying a etcd cluster is necessary to install the etcd CLI to interact with the cluster. This can be achieved by running:
```bash
git clone https://github.com/etcd-io/etcd.git
cd etcd
./build.sh
export PATH="$PATH:`pwd`/bin"
# Test that etcd was correctly installed and is on PATH
etcd --version
```

## Deploy local cluster

The [run_local_etcd](./run_local_etcd) file is a python script that spawns a local etcd cluster. It takes as input the number of nodes, the network name connecting the containers and an option to spawn the containers in parallel.
As an example, to create a cluster with 3 nodes run:
```bash
sudo ./run_local_etcd -c 3 -f true
```
This will output a command to export the `ENDPOINTS` variable to then be passed to the `etcdctl` and `benchmark` tools. E.g.:
```bash
export ENDPOINTS=http://127.0.0.1:5000,http://127.0.0.1:5001,http://127.0.0.1:5002
```
Confirm that the containers have been correctly spawned by running:
```bash
sudo docker ps
```
and to confirm that the cluster is working run:
```bash
etcdctl --endpoints=$ENDPOINTS member list
```

## Benchmark

Etcd provides a benchmarking tool available for download [here](https://github.com/etcd-io/etcd/tree/main/tools/benchmark).

To test the system we used variations of the following command:
```bash
time benchmark txn-mixed --consistency s --key-size 256 --clients 1000 --conns 100 --endpoints $ENDPOINTS --total 500000
```
Arguments:
- `txn-mixed` runs a benchmark with both `put` and `range` commands
- `--consistency` sets the consistency level for the `range` commands, either serializable or linearizable
- `--key-size` sets the key size
- `--clients` sets the number of clients sending requests
- `--conns` sets the total number of connections
- `--endpoints` sets the endpoints of the cluster
- `--total` sets the total number of operations
