#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
port=2888
dst_path="/home/joer/temp/BPF-KV"
outer_loops=5  
for ((j=1; j<=$outer_loops; j++)); do
    echo $j
    for ((i=0; i<=$j; i++)); do 
        echo $i
        sshpass -p $pswd ssh -tt -p $port$i $vm "cd ${dst_path} && ./simplekv ../../p1/5 5 get -r 100000" &
        # let "result=i+4"
        # sshpass -p $pswd ssh -tt -p $port$result $vm "cd ${dst_path} && ./simplekv ../../p1/5 5 get -r 100000" &
    done

    sleep 20
    echo "next"
done
