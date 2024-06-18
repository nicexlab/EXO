#!/bin/bash  
  
# 定义源文件和目标目录  
SOURCE_FILE="/home/joer/vms/vhost.qcow2"  # 替换为disk0.raw文件的实际路径  
TARGET_DIRS=("/home/joer/vms/")  # 替换为目标文件夹的实际路径数组  
  
# 检查源文件是否存在  
if [ ! -f "$SOURCE_FILE" ]; then  
    echo "Error: Source file $SOURCE_FILE does not exist."  
    exit 1  
fi  
  
# 初始化一个等待所有后台任务完成的进程ID数组  
declare -a pids  
  
# 函数：拷贝文件到目标目录，并在后台运行  
copy_to_target() {  
    local target_dir=$1  
    local file_base=$(basename "$SOURCE_FILE")  
    local target_file  
  
    # 在目标目录中创建拷贝  
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
