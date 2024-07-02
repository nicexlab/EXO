#!/bin/bash  
  
# prepared virtual machine image
SOURCE_FILE="/home/joer/vms/vhost0.qcow2"  
TARGET_DIRS=("/home/joer/vms/") 
  
  
if [ ! -f "$SOURCE_FILE" ]; then  
    echo "Error: Source file $SOURCE_FILE does not exist."  
    exit 1  
fi  
  

declare -a pids  
  
# copy in backend
copy_to_target() {  
    local target_dir=$1  
    local file_base=$(basename "$SOURCE_FILE")  
    local target_file  
  

    for i in {0..3}; do  
        target_file="${target_dir}/vhost${i}.qcow2"  
        cp "$SOURCE_FILE" "$target_file" &  # 在后台执行拷贝  
        pids[$!]=1  # 将后台进程的PID保存到数组中  
    done  
}  
  
# 对每个目标目录调用拷贝函数  
for target_dir in "${TARGET_DIRS[@]}"; do  
    copy_to_target "$target_dir"  
done  
  
# 等待所有后台任务完成  
for pid in "${!pids[@]}"; do  
    wait "$pid"  # 等待指定的进程ID完成  
done  
  
echo "All files have been copied successfully."
