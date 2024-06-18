#!/bin/bash  
# 定义环境变量和sh文件路径
SPDK="/home/joer/spdk"
devices=("nvme2")
SET_UP="$SPDK/scripts/setup.sh"
nvme_pci_addr="10000:e3:00.0"
Hugemem_size=8192
RPC="$SPDK/scripts/rpc.py"  
VHOST="$SPDK/build/bin/vhost"
operation=reset
operation1=config
operation2=status



bash $SET_UP $operation &

for device in "${devices[@]}"; do 
    echo "reseting the nvme device"
    sudo nvme detach-ns "/dev/$device" -c 0 -n 1
    sudo nvme delete-ns "/dev/$device" -n 1
    sudo nvme create-ns "/dev/$device" -s 650000000 -c 650000000 -f 0 -d 0 -m 0
    sudo nvme attach-ns "/dev/$device" -c 0 -n 1
    sudo nvme reset  "/dev/$device"
    echo "reset done"
done
# 使用nohup在后台运行第一个脚本，并将输出重定向到nohup.out文件中  


echo "HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation1"
HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation1
echo "HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation2"
HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation2

$VHOST -S /var/tmp -m 0x1 
# nohup sh "$VHOST -S /var/tmp -m 0xFF" > /dev/null 2>&1 &  

# $RPC bdev_nvme_attach_controller -b nvme0 -t pcie -a $nvme_pci_addr
# # 使用nohup在后台运行第二个脚本，并将输出重定向到nohup.out文件中  
# nohup python3 "$RPC bdev_nvme_attach_controller -b nvme0 -t pcie -a $nvme_pci_addr" >/dev/null 2>&1 &  

