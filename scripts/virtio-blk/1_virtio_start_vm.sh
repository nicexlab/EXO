#!/bin/bash  
VM_COUNT=1
qemu_pids=$(pgrep qemu)
Root='console=ttyS0 root=/dev/sda5'
# kill all qemu process
echo "Killing all running QEMU processes..."  
sudo pkill -f qemu-system-x86_64  
sleep 5   
space=" " 

qemu_processes=$(pgrep -f qemu-system-x86_64)  
if [ -n "$qemu_processes" ]; then  
    echo "Warning: Some QEMU processes may still be running."  
    exit 1  
fi  

# start the VM 
BASE_CMD="sudo /home/joer/vhost-blk-xrp/EXO/qemu/build/qemu-system-x86_64"  
KERNEL="  -kernel /boot/vmlinuz-6.1.0-rc8-origin+ -initrd /boot/initrd.img-6.1.0-rc8-origin+"


for i in $(seq 1 $VM_COUNT); do  
    # 构造每个虚拟机的独特参数  
    echo "start $i"
    VM_SET="-smp 4 -m 4096 -enable-kvm -hda /home/joer/vms/vhost$i.qcow2"
    SOCK="-net user,hostfwd=::2888$i-:22 -net nic -append root=/dev/sda5"
    DISK="  -drive if=none,id=drive1,format=raw,file=/home/joer/optaneA/virtual-disk/disk$i.raw,cache=none -device virtio-blk-pci,id=blk1,drive=drive1,num-queues=1"
    UNIQUE_ARG="-overcommit mem-lock=on"
    # MEM=" -object memory-backend-file,id=mem,size=2G,mem-path=/dev/hugepages/$i,share=on -numa node,memdev=mem"
    # UNIQUE_ARG="-chardev socket,id=char$i,path=/var/tmp/vhost.0$i -device vhost-user-blk-pci,id=blk0,chardev=char$i,num-queues=4 &"  

    # 组合命令  
    FULL_CMD="$BASE_CMD $VM_SET $KERNEL $SOCK $DISK $UNIQUE_ARG"  
      
    # 在后台运行虚拟机，并将输出重定向到日志文件  
    echo $FULL_CMD
    # nohup $FULL_CMD > /tmp/vm_output_$i.log 2>&1 &  
    $FULL_CMD &
    # 稍作延时，避免同时启动过多进程造成的资源竞争  
    sleep 2
done  

echo "所有虚拟机已启动。"

# sudo /home/joer/qemu/build/qemu-system-x86_64 -smp 4 -m 4096 -enable-kvm -hda /home/joer/vms/vhost2.qcow2 -kernel /boot/vmlinuz-6.1.0-guest+ -initrd /boot/initrd.img-6.1.0-guest+ -net user,hostfwd=::28881-:22 -net nic -append root=/dev/sda5 -drive if=none,id=drive1,format=raw,file=/home/joer/optaneA/virtual-disk/disk1.raw,cache=none -object '{"qom-type": "iothread", "id": "t1"}' -object '{"qom-type": "iothread", "id": "t2"}' -object '{"qom-type": "iothread", "id": "t3"}' -object '{"qom-type": "iothread", "id": "t4"}' -device '{"driver":"virtio-blk-pci","id":"blk1",drive":"drive1","num-queues":4,"iothread-vq-mapping":[{"iothread":"t1"},{"iothread":"t2"},{"iothread":"t3"},{"iothread":"t4"}]}' -overcommit mem-lock=on