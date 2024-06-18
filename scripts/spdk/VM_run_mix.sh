#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
port=2888
dst_path="/home/joer/"
BPF_path="/home/joer/temp/BPF-KV"
outer_loops=6  
for ((j=0; j<$outer_loops; j++)); do
    
    echo "$j"
    for ((i=0; i<=$j; i++)); do 
        sshpass -p $pswd scp -P $port$i ./time.fio ${vm}:$dst_path
    done
    
    for ((i=0; i<=$j; i++)); do 
        echo '123'| sshpass -p $pswd ssh -tt -p $port$i $vm "cd ${dst_path} && fio time.fio --output $dst_path/output.tmp --output-format=json" &
    done
    sshpass -p $pswd ssh -tt -p 28886 $vm "cd ${BPF_path} && ./simplekv ../../p1/5 5 get -r 100000" &
    sleep 310
    
    # for ((i=0; i<=$j; i++)); do 
    #     sshpass -p $pswd scp -P $port$i ${vm}:$dst_path/output.tmp ./output/$j/output$i.json
    # done
done
