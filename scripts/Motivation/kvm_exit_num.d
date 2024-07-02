#!/usr/bin/bpftrace

struct kvm_io_range {
	unsigned int64 addr;
	int len;
	void * a;
};

kprobe:__kvm_io_bus_write
{
    range = (struct kvm_io_range) arg2;
    if(arg2->addr>=0xfe003000&&arg2->addr<=0xfe00301c)
    {
        @[probe]=count();
    }
}

