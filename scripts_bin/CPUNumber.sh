#!/bin/bash
cpu=`grep "physical id" /proc/cpuinfo |sort -u |wc |awk '{print $1}'`
echo "CPU number ---------------" ${cpu}

core=`grep "cpu cores" /proc/cpuinfo |sort -u |awk '{print $4'}`

echo "Core number of each CPU ----" ${core}

p1=`echo "${cpu}*${core}"|bc`

echo "Total core number -----" ${p1}

p=`grep -c processor /proc/cpuinfo`

echo "Total processor number -----" ${p}

ht="No"

if [ ${p1} -lt $p ]; then

 ht="Yes"

fi

echo "Using Hyper-Threadingi -----" ${ht}

