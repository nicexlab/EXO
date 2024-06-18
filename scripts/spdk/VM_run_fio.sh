#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
port=2888
dst_path="/home/joer/"
outer_loops=5  
for ((j=0; j<=$outer_loops; j++)); do
    echo $j
    for ((i=0; i<=$j; i++)); do 
        sshpass -p $pswd scp -P $port$i ./time.fio ${vm}:$dst_path
    done

    for ((i=0; i<=$j; i++)); do 
        echo $i
        echo '123'| sshpass -p $pswd ssh -tt -p $port$i $vm "cd ${dst_path} && fio time.fio --output $dst_path/output.tmp --output-format=json" &
    done

    sleep 125
    echo "copy"
    for ((i=0; i<=$j; i++)); do 
        sshpass -p $pswd scp -P $port$i ${vm}:$dst_path/output.tmp ./output/$j/output$i.json
    done
done
