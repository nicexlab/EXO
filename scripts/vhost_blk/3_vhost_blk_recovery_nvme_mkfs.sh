#!/bin/bash  
# 定义环境变量和sh文件路径  
devices=("nvme0")
ns1="n1"
ns2="n2"
ns3="n3"
ns4="n4"
ns5="n5"
for device in "${devices[@]}"; do 
    echo "reseting the nvme device"
    sudo nvme detach-ns "/dev/$device" -c 0 -n 1
    sudo nvme detach-ns "/dev/$device" -c 0 -n 2
    sudo nvme detach-ns "/dev/$device" -c 0 -n 3
    sudo nvme detach-ns "/dev/$device" -c 0 -n 4
    sudo nvme detach-ns "/dev/$device" -c 0 -n 5

    sudo nvme delete-ns "/dev/$device" -n 1
    sudo nvme delete-ns "/dev/$device" -n 2
    sudo nvme delete-ns "/dev/$device" -n 3
    sudo nvme delete-ns "/dev/$device" -n 4
    sudo nvme delete-ns "/dev/$device" -n 5

    sudo nvme create-ns "/dev/$device" -s 650000000 -c 650000000 -f 0 -d 0 -m 0

    sudo nvme attach-ns "/dev/$device" -c 0 -n 1
    sudo nvme reset  "/dev/$device"
    echo "reset done"
    sudo mkfs.ext4 "/dev/$device$ns1"

done
