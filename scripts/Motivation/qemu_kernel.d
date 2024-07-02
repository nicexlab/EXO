#!/usr/bin/bpftrace
uprobe:/home/joer/vhost-blk-xrp/qemu-vhost-blk/build/qemu-system-x86_64:handle_aiocb_rw_linear  
{
    @t_start=nsecs;
}
kprobe:vfs_read
/@t_start/
{

    @my_avg = avg(nsecs - @t_start);
    @my_hist = lhist(nsecs - @t_start, 0, 1000, 20);
    clear(@t_start);
}

