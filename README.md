# Etcd Performance and Scalability

The system at study is [etcd](https://etcd.io/).

## Project Structure

- [benchmarks-l](./benchmarks-l/) and [benchmarks-s](./benchmarks-s/) contain the experimental data and scripts to generate the plots
- [scripts](./scripts/) scripts uses to run the cluster and benchmarks
- [etcd](./etcd/) contains the source code for etcd added as as git submodule

## Requirements
- Docker
- Vagrant

## Etcd CLI

A shell with `etcdctl` can be spawned using docker by running the following command:
```bash
docker run -it --rm --hostname "client" bitnami/etcd bash
```

## Deploy cluster on Google Cloud Platform
1. Enter the vagrant provisioned docker container.
```sh
cd infra/deploy
vagrant up
vagrant ssh
```
2. Copy `terraform.tfvars.example` to `terraform.tfvars` and change the values accordingly.
3. Deploy the infrastructure with terraform.
```tf
terraform plan -out tf.lock
terraform apply tf.lock
```
4. Change the path to the ssh key in `ansible.cfg`
5. Run the playbooks
```sh
ansible-playbook playbooks/admin.yml
ansible-playbook playbooks/mount-ssd.yml
ansible-playbook playbooks/deploy-containers.yml
```

The deployment presented above also provisions a VM to run the benchmarks.
If all the steps are successful, all the user needs to do to run the benchmark is:

```sh
ssh ubuntu@<admin-machine> -i <path-to-ssh-key>
source nodes.sh
time benchmark txn-mixed --rw-ratio=4 --consistency s --key-size 256 --clients 1000 --conns 100 --endpoints $ENDPOINTS --total 500000  
```

## Benchmark

Etcd provides a benchmarking tool available for download [here](https://github.com/etcd-io/etcd/tree/main/tools/benchmark).

To test the system we used variations of the following command:
```bash
time benchmark txn-mixed --rw-ratio=4 --consistency s --key-size 256 --clients 1000 --conns 100 --endpoints $ENDPOINTS --total 500000  
```
Arguments:
- `txn-mixed` runs a benchmark with both `put` and `range` commands
- `--consistency` sets the consistency level for the `range` commands, either serializable or linearizable
- `--key-size` sets the key size
- `--clients` sets the number of clients sending requests
- `--conns` sets the total number of connections
- `--endpoints` sets the endpoints of the cluster
- `--total` sets the total number of operations
