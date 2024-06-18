#!/bin/bash  
VM_COUNT=5

Root='console=ttyS0 root=/dev/sda5'
# 杀掉所有QEMU进程  
echo "Killing all running QEMU processes..."  
sudo pkill -f qemu-system-x86_64  
sleep 5  # 等待一段时间确保进程已经被杀死  
space=" " 
# 检查是否还有QEMU进程在运行  
qemu_processes=$(pgrep -f qemu-system-x86_64)  
if [ -n "$qemu_processes" ]; then  
    echo "Warning: Some QEMU processes may still be running."  
    exit 1  
fi  

# 虚拟机的基础启动命令  
BASE_CMD="sudo /home/joer/vhost-blk-xrp/qemu-vhost-blk/build/qemu-system-x86_64"  
KERNEL="  -kernel /boot/vmlinuz-5.15.0-67-generic -initrd /boot/initrd.img-5.15.0-67-generic"


for i in $(seq 1 $VM_COUNT); do  
    # 构造每个虚拟机的独特参数  
    echo "start $i"
    VM_SET="-smp 2 -m 1024 -enable-kvm -hda /home/joer/vms/vhost$i.qcow2"
    SOCK="-net user,hostfwd=::2888$i-:22 -net nic -append root=/dev/sda5"
    let "Vhost_num=i-1" 
    DISK="  -chardev socket,id=char$Vhost_num,path=/var/tmp/vhost.0$Vhost_num -device vhost-user-blk-pci,id=blk0,chardev=char$Vhost_num,num-queues=2"
    UNIQUE_ARG="-overcommit mem-lock=on"
    MEM=" -object memory-backend-file,id=mem,size=1G,mem-path=/dev/hugepages/$i,share=on -numa node,memdev=mem"
    # UNIQUE_ARG=""  


    # 组合命令  
    FULL_CMD="$BASE_CMD $VM_SET $KERNEL $SOCK $MEM $DISK $UNIQUE_ARG"  
      
    # 在后台运行虚拟机，并将输出重定向到日志文件  
    echo $FULL_CMD
    # nohup $FULL_CMD > /tmp/vm_output_$i.log 2>&1 &  
    $FULL_CMD &
    # 稍作延时，避免同时启动过多进程造成的资源竞争  
    sleep 2
done  

echo "所有虚拟机已启动。"
