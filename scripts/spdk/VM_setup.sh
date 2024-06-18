#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
dst_path="/home/joer/"



for ((i=0; i<=11; i++)); do
    let "port=28880+i"
    echo $i
    scp -P $pswd ssh -tt -P $port $vm
    echo '123'|sshpass -p $pswd ssh -tt -p $port $vm "sudo /home/joer/VM_set_up_fio.sh" &
done

# for ((i=0; i<=7; i++)); do 
#     echo $i
#     echo '123'| sshpass -p $pswd ssh -tt -p $port$i $vm "sudo shutdown now" &
# done