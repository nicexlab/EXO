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
git submodule init
git submodule update
```
install linux kernel dependencies
```
sudo apt-get install ninja-build acpica-tools buildessential zlib1g-dev pkg-config libglib2.0-dev binutils-dev libboost-all-dev autoconf libtool libssldev libpixman-1-dev libpython2-dev python3-pip python-capstone virtualenv libpixman-1-dev libbpf-dev libcap-ng-dev libseccomp-dev
```
Compile and install Linux kernel:
```
cd linux
sudo make bindeb-pkg -j20
cd ..
sudo dpkg -i *.deb
vim /etc/default/grub // Choose the kernel installed just now
sudo update-grub
```

