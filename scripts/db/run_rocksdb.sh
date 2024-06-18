#/bin/bash

YCSB_dir="/home/joer/YCSB-cpp"
log_file="/home/joer/result"
# rm -r /home/joer/p1/rocksdb/ycsb-rocksdb-data
workloads="a b c d e f"
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#  numactl -N 0 -m 0 redis-server ./redis.conf
# ./bin/ycsb.sh load rocksdb -threads 4 -s -P workloads/workloada -p rocksdb.dir=/home/joer/p1/rocksdb/ycsb-rocksdb-data 2>&1
# sudo rm $Guest_lib/librocksdb*
# sudo cp $work_dir/librocksdb.so.9.2.0 $Guest_lib
# for lib in $ROCKSDB_LIB; do
#     sudo ln -s $Guest_lib/librocksdb.so.9.2.0 $Guest_lib/$lib
# done
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
for ((i=1; i<=4; i++)); do  
  for file_name in $workloads; do
      echo "Running rocksdb with for $file_name"
      $YCSB_dir/build/ycsb -run -db rocksdb -threads $i -P $YCSB_dir/workloads/workload$file_name \
      -P $YCSB_dir/rocksdb/rocksdb.properties -s\
      > $log_file/$i/$file_name 2>&1
      # ./bin/ycsb.sh run rocksdb -threads $i -s -P workloads/workload$file_name \
      # -p rocksdb.dir=/home/joer/p1/rocksdb/ycsb-rocksdb-data \
      # > $log_file/$i/$file_name 2>&1
    wait
  done
done  

