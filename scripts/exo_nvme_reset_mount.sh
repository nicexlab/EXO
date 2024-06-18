#!/bin/bash  
# 定义环境变量和sh文件路径  
devices=("nvme0" "nvme2")
num=1
ns="n1"

for device in "${devices[@]}"; do 
    echo "reseting the nvme device"
    sudo nvme delete-ns "/dev/$device" -n 1
    sudo nvme create-ns "/dev/$device" -s 650000000 -c 650000000 -f 0 -d 0 -m 0
    sudo nvme attach-ns "/dev/$device" -c 0 -n 1
    sudo nvme reset "/dev/$device$ns"
    echo "reset done"
    sudo mkfs.ext4 "/dev/$device$ns"
    # sudo mount "/dev/$device$ns" "/home/joer/$num"
    # sudo chown joer "/home/joer/p5800$num"
    # num=$((num + 1))
done
