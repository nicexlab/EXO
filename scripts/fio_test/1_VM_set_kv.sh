#!/bin/bash

vm="joer@127.0.0.1"
pswd="123"
dst_path="/home/joer/"

for ((i=1; i<=5; i++)); do
    let "port=28880+i"
    echo $i
    echo '123'| scp -P $port  /home/joer/vhost-blk-xrp/scripts/fio_test/guest_VM_install_kv.sh $vm:$dst_path
    echo '123'| sshpass -p $pswd ssh -tt -p $port $vm "sudo /home/joer/guest_VM_install_kv.sh" &
done

# for ((i=0; i<=7; i++)); do 
#     echo $i
#     echo '123'| sshpass -p $pswd ssh -tt -p $port$i $vm "sudo shutdown now" &
# done