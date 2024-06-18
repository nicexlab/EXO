#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
port=2888
port_L=28881
dst_path="/home/joer/"
outer_loops=4 
LAPP_path="/home/joer/vhost-blk-xrp/scripts/time_l.fio"
TAPP_path="/home/joer/vhost-blk-xrp/scripts/time_t.fio"
for ((i=1; i<=5; i++)); do
    let "port=28880+i"
    echo $i
    echo '123'| scp -P $port  $LAPP_path $vm:$dst_path
    echo '123'| scp -P $port  $TAPP_path $vm:$dst_path
done

for ((j=1; j<=$outer_loops; j++)); do
    echo $j
    for ((i=0; i<$j; i++)); do
        let "port_T=28882+i" 
        echo $port_T
        sshpass -p $pswd ssh -tt -p $port_T $vm "fio $dst_path/time_t.fio --output $dst_path/output_t.tmp --output-format=json" &
    done

    sshpass -p $pswd ssh -tt -p $port_L $vm "fio $dst_path/time_l.fio --output $dst_path/output_l.tmp --output-format=json" &


    sleep 70
    for ((i=0; i<$j; i++)); do 
        let "port_T=28882+i" 
        scp -P $port_T ${vm}:$dst_path/output_t.tmp ../output/$j/output_t$i.json
    done
    scp -P $port_L ${vm}:$dst_path/output_l.tmp ../output/$j/output_l.json
done
