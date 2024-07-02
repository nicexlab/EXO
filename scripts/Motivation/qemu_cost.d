#!/usr/bin/bpftrace

uprobe:/home/joer/vhost-blk-xrp/qemu-vhost-blk/build/qemu-system-x86_64:virtio_blk_handle_output  
{
    @t_start=nsecs;
}

uprobe:/home/joer/vhost-blk-xrp/qemu-vhost-blk/build/qemu-system-x86_64:handle_aiocb_rw_linear
/@t_start/
{

    @my_avg = avg(nsecs - @t_start);
    @my_hist = lhist(nsecs - @t_start, 0, 15000, 50);
    clear(@t_start);
}

