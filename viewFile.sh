#!/bin/bash
set -x
#cat /proc/meminfo
echo "This is the content of dir"
ls -lRt
echo "memory usage"
df -kh
echo "hostname"
hostname
