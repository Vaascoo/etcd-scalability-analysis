HOW TO SETUP:

sudo ./run_local_etcd -c <N> -f true
export ENDPOINTS=...
etcdctl --endpoints=$ENDPOINTS member list
time benchmark txn-mixed --consistency s --key-size 256 --clients 1000 --conns 100 --endpoints $ENDPOINTS --total 500000

update the data.csv
java -jar esle-usl.jar data.csv
(copy values to data.gp)
gnuplot data.gp

DADOS:

#size tput
1, 9000
2, 9400
3, 10000
4, 10100
5, 9943
6, 9350
7, 9229
8, 8733
9, 8000