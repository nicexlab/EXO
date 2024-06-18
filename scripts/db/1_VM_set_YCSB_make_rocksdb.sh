#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
port=8888
dst_path="/home/joer/"
TARGET_DIRS=("a" "b" "c" "d" "e" "f")
ROCKSDB_DIR="/home/joer/vhost-blk-xrp/scripts/db/rocksdb/"


# echo '123'| scp -r -P $port  /home/joer/vhost-blk-xrp/scripts/db/rocksdb $vm:$dst_path
# echo '123'| scp -r -P $port  /home/joer/vhost-blk-xrp/scripts/db/YCSB-cpp $vm:$dst_path
echo '123'| scp -r -P $port  /home/joer/vhost-blk-xrp/scripts/db/ycsb-rocks-db $vm:$dst_path/p1
echo '123'| scp -r -P $port  /home/joer/vhost-blk-xrp/scripts/db/run_rocksdb.sh $vm:$dst_path
# echo '123'| scp -r -P $port  $ROCKSDB_DIR/librocksdb.so.9.2.0 $vm:$dst_path
# sshpass -p $pswd ssh -tt -p $port$i $vm "rm -r $dst_path/result"
# sshpass -p $pswd ssh -tt -p $port$i $vm "mkdir $dst_path/result"
# for ((j=1; j<=4; j++)); do
#     sshpass -p $pswd ssh -tt -p $port$i $vm "mkdir $dst_path/result/$j"
# done

