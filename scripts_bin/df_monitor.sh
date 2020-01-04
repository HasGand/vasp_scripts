#!/usr/bin/sh
num=1
while true
do
	if [[ `echo "$(df -h |grep /dev |awk '{printf("%d", $(NF-1))}') >= $num" |bc` -eq 1  ]]
	then
		echo -e "/home的硬盘使用率已达${num}%,请留意！" >> ~/attention_from_home
		break
	fi
	sleep 43200
done
