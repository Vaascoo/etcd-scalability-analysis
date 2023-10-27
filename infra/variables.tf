variable "GCP_PROJECT_ID" {
  default = "esle-402917"
}

variable "GCP_MACHINE_TYPE" {
  default = "n1-standard-1"
}

variable "GCP_ADMIN_MACHINE_TYPE" {
  default = "n1-standard-32"
}

variable "GCP_ZONE" {
  default = "northamerica-northeast1-b"
}

variable "NODE_COUNT" {
  default = "3"
}

# source nodes.sh

# etcdctl member list --endpoints=$ENDPOINTS

# time benchmark txn-mixed --rw-ratio=4 --consistency s --key-size 256 --clients 1000 --conns 100 --endpoints $ENDPOINTS --total 500000
