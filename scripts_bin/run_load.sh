#!/usr/bin/sh
echo -e "\n"
printf "%-100s%s\n" "||==================================================================================================" "||"
printf "%-100s%s\n" "||My pid is $$, and my name is $0" "||"
printf "%-100s%s\n" "||==================================================================================================" "||"
echo -e "\n"

commod=$*
load=0.8
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
