#!/usr/bin/sh
_help_(){
	cat << !
||========================================================================||
||Usage:	run_time_load.sh [day] [hour] [minute] [load] [commod*]   ||
||		run_time_load.sh -h,	 For help			  ||
||              run_time_load.sh --help,  Get detailed help information   ||
||									  ||
||Attention:	All dates require two digits,                             ||
||		and load must be 0.3 or more and 1 or less.		  ||
||									  ||
||Tips:		If you want to run in the background,                     ||
||		you may enter like this:				  ||
||			nohup run_time_load.sh 02 02 02 0.8 echo 123 &	  ||
||									  ||
||Description:	The script will periodically run user-entered 		  ||
||		commands based on user-entered time and load.		  ||
||									  ||
||Report bugs to <madebyrjh@hnu.edu.cn>.				  ||
||========================================================================||
!
}

case $1 in
	-h)
		echo "Usage: run_time_load.sh [day] [hour] [minute] [load] [commod*]"
        	exit 0
		;;
	--help)
		_help_
        	exit 0
		;;
	[0-3][0-9])
		;;
	*)
		echo "Error: Invalid date input --- day!"
		exit 1
		;;
esac

for i in $2 $3
do
	case $i in
		[0-6][0-9])
			;;
		*)
			if [[ $i == $2 ]]; then temp="hour"; else temp="minute"; fi
			echo "Error: Invalid date input --- $temp!"
			exit 1
			;;
	esac
done

load=$4
if [[ `echo "$load <= 1 && $load >=0.3"|bc` -eq 0  ]]
then
        echo -e "Error: load must be 0.3 or more and 1 or less!!!"
        echo -e "       If the load is too high, it may lead to premature submission of tasks.\n"
        exit 1
fi

_day_=$1
_time_h_=$2
_time_m_=$3
time_sleep=10
#_time_s_=$4
shift 4
commod=$*
if [[ ! $commod ]];then
	echo "Error: command is empty!!!"
	exit 1
fi

#echo -e "||I will submit your commod, when the time is $_day_--$_time_h_:$_time_m_:$_time_s_. ||"
printf "%-100s%s\n" "||==================================================================================================" "||"
printf "%-100s%s\n" "||I will submit your commod, when the time is $_day_-$_time_h_:$_time_m_:xx." "||"
printf "%-100s%s\n" "||Your commod is :               " "||"
printf "%-100s%s\n" "||                 $commod" "||"
printf "%-100s%s\n" "||And my pid is $$, my name is $0" "||"
printf "%-100s%s\n" "||==================================================================================================" "||"
echo -e "\n"

while true
do
	date_=$(date +"%Y-%m-%d %H:%M:%S")
	day=$(echo $date_ |awk '{print $1}' |awk 'BEGIN{FS="-"}{printf("%s"), $3}')
	time_h=$(echo $date_ |awk '{print $2}'|awk 'BEGIN{FS=":"}{printf("%s"), $1}')
	time_m=$(echo $date_ |awk '{print $2}'|awk 'BEGIN{FS=":"}{printf("%s"), $2}')
	#time_s=$(echo $date_ |awk '{print $2}'|awk 'BEGIN{FS=":"}{printf("%s"), $3}')

	if [[ $day == $_day_ ]]
	then
		#if [[ $time_h == $_time_h_ && $time_m == $_time_m_ && $time_s == $_time_s_ ]]
		if [[ $time_h == $_time_h_ && $time_m == $_time_m_ ]]
		then
			echo "Now, the date is [`echo $date_`]"
			echo -e "It's time to check the load!\n"
			echo -e "...........................................................................................................\n"
			while echo -e "need load average < $load ;当前uptime：$(uptime | awk '{print }')"
			do
			        if [[ `echo "$(uptime |awk '{printf("%f",$(NF-1))}') < $load" |bc` -eq 1 ]]
			        then
			                echo -e "\n\nNow, load average < $load, it's time to run!\n"
					echo "............................................................................................................"
			                echo -e `$commod >> commod.out`
					wait
			                break
			        fi
			        sleep ${time_sleep}
			        echo -e "after ${time_sleep} sec... load=$(uptime |awk '{printf("%f",$(NF-1))}')"
			done
			break
		fi
	fi
	sleep 59
done
echo "Everything is done, bye!"
exit 0
