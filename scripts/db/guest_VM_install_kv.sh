#!/bin/bash

./bin/ycsb.sh load rocksdb -s -P workloads/workloada -p rocksdb.dir=/home/joer/p1/rocksdb/ycsb-rocksdb-data 

./bin/ycsb.sh run rocksdb -s -P workloads/workloada -p rocksdb.dir=/home/joer/p1/rocksdb/ycsb-rocksdb-data

scp -r -P 8888 joer@127.0.0.1:/home/joer/p1/result result/virtio-blk/

./ycsb -run -db rocksdb -P workloads/workloade -P rocksdb/rocksdb.properties -s

scp -r -P 8888 joer@127.0.0.1:/home/joer/result /home/joer/vhost-blk-xrp/scripts/db/result/vi
rtio-blk/