#!/usr/bin/bpftrace

kprobe:__kvm_io_bus_write
{
    @t_start=nsecs;
}

uprobe:/home/joer/vhost-blk-xrp/qemu-vhost-blk/build/qemu-system-x86_64:aio_ctx_dispatch  
/@t_start/
{

    @my_avg = avg(nsecs - @t_start);
    @my_hist = lhist(nsecs - @t_start, 0, 5000, 20);
    clear(@t_start);
}

