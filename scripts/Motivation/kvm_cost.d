#!/usr/bin/bpftrace

kprobe:vmx_handle_exit
{
    @t_start=nsecs;
}

kprobe:__kvm_io_bus_write
/@t_start/
{

    @my_avg = avg(nsecs - @t_start);
    @my_hist = lhist(nsecs - @t_start, 0, 500, 20);
    clear(@t_start);
}

