#!/usr/bin/sh
echo ""
echo -e "|-----------------------------------------------------------------------------------------|"
echo -e "|		(*^_^*)The task number for this script is $$.				   |"
echo -e "|		You can kill the $0 through the task number!.(￣y▽,￣)╭ 		   |"
echo -e "|-----------------------------------------------------------------------------------------|"
echo -e "\n"

commod=$*
load=45.00
time_sleep=10
while echo -e "need load average < $load ;当前uptime：$(uptime | awk '{print }')"
do
	if [[ `echo "$(uptime |awk '{printf("%f",$(NF-1))}') < $load" |bc` -eq 1 ]]
	then
		echo -e "\n\n\nNow, load average < $load\n\n\n"
		echo -e `$commod >> commod.out`
		break
	fi
	sleep ${time_sleep}
	echo -e "after ${time_sleep} sec... load=$(uptime |awk '{printf("%f",$(NF-1))}')"
done
