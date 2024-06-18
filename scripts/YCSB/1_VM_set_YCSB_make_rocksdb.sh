#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
port=8888
dst_path="/home/joer/p1"

echo '123'| scp -r -P $port  /home/joer/vhost-blk-xrp/scripts/YCSB/YCSB $vm:$dst_path
# echo '123'| sshpass -p $pswd ssh -tt -p $port $vm "cd $dst_path && mvn -pl site.ycsb:rocksdb-binding -am clean package" 


# for ((i=0; i<=7; i++)); do 
#     echo $i
#     echo '123'| sshpass -p $pswd ssh -tt -p $port$i $vm "sudo shutdown now" &
# done