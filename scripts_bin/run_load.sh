#!/usr/bin/sh
echo ""
echo -e "|-----------------------------------------------------------------------------------------|"
echo -e "|		(*^_^*)The task number for this script is $$.				   |"
echo -e "|		You can kill the $0 through the task number!.(￣y▽,￣)╭ 		   |"
echo -e "|-----------------------------------------------------------------------------------------|"
echo -e "\n"

commod=$*
load=0.8
while echo -e "need load average < $load ;当前uptime：$(uptime | awk '{print }')"
do
	if [[ `echo "$(uptime | awk '{printf("%f"), $9}') < $load" |bc` -eq 1 ]]
	then
		echo -e "\n\n\nNow, load average < $load\n\n\n"
		echo -e `$commod >> commod.out`
		break
	fi
	sleep 10
	echo -e "after 10 sec..."
done
