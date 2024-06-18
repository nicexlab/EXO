# EXO: Accelerating Storage Paravirtualization with eBPF

This repository contains source code and instructions to reproduce key results in the EXO paper (to appear in SC '24). A draft of the paper is added to this repository.

EXO requires a low latency NVMe SSD on which the overhead of the Linux storage stack is significant. We use Intel Optane SSD P5800X in all the experiments. We provide SSH access to a host equipped with P5800X for artifact reviewers. Reviewers can find the credential on HotCRP. We assume that the operating system is Ubuntu 20.04, and there are 20 physical CPU cores on the machine. Other configurations may require changing the scripts accordingly.

There are four major components:

* Modified Linux kernel (based on v6.1) that supports EXO
* Modified Qemu (based on v7.1.50) that supports EXO
* eBPF source code include virtio-blk backend and part of Qcow2 logical
* Benchmarks and scripts used for experiments

# Getting Started
First, clone this repository in a folder that is large enough to compile Linux kernel:
```
git clone https://github.com/system-xmu/EXO.git

```

