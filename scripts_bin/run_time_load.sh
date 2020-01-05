#!/usr/bin/sh
_help_(){
cat << !
||========================================================================||
||Usage:	run_time_load.sh [day] [hour] [minute] [load] [command*]  ||
||		run_time_load.sh [load] [command*]			  ||
||		run_time_load.sh -h,	  For help			  ||
||              run_time_load.sh --help,  Get detailed help information   ||
||									  ||
||Attention:	All dates require two digits,                             ||
||		and load must be $load_min or more and $load_max or less.		  ||
||		But if you don't need to submit tasks on time,		  ||
||		the value of the load is up to you. So, you have 	  ||
||		to pay more attention to it.				  ||
||									  ||
||Tips:		If you want to run in the background,                     ||
||		you may enter like this:				  ||
||			nohup run_time_load.sh 02 02 02 0.8 echo 123 &	  ||
||		        nohup run_time_load.sh 0.8 echo 123 &		  ||
||									  ||
||Description:	The script will run user-entered command,	  	  ||
||		based on user-entered time and load.		 	  ||
||									  ||
||Report bugs to <madebyrjh@hnu.edu.cn>.				  ||
||========================================================================||
!
}

CheckLoad(){
while echo -e "need load average < $load ;当前uptime：$(uptime | awk '{print }')"
do
       	if [[ `echo "$(uptime |awk '{printf("%f",$(NF-1))}') < $load" |bc` -eq 1 ]]
       	then
	        echo -e "\n\nNow, load average < $load, it's time to run!\n"
	        echo "............................................................................................................"
	        echo -e `$command >> command.out`
	        wait
	        return 0
        fi
       	sleep ${load_sleep}
        echo -e "after ${load_sleep} sec... load=$(uptime |awk '{printf("%f",$(NF-1))}')"
done
return check_flag=$[ $check_flag + 1 ]
}

CheckTime(){
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
                        $*
                        return 0
                fi
        fi
        sleep 59
done
return check_flag=$[ $check_flag + 2 ]
}

Start(){
#echo -e "||I will submit your command, when the time is $_day_--$_time_h_:$_time_m_:$_time_s_. ||"
printf "%-100s%s\n" "||==================================================================================================" "||"
printf "%-100s%s\n" "||I will submit your command, when the time is $_day_-$_time_h_:$_time_m_:xx and the load is $load or less." "||"
printf "%-100s%s\n" "||Your command is :               " "||"
printf "%-100s%s\n" "||                 $command" "||"
printf "%-100s%s\n" "||And my pid is $$, my name is $0" "||"
printf "%-100s%s\n" "||==================================================================================================" "||"
echo -e "\n"
}
Start1(){
printf "%-100s%s\n" "||==================================================================================================" "||"
printf "%-100s%s\n" "||I will submit your command, when  the load is $load or less." "||"
printf "%-100s%s\n" "||Your command is :               " "||"
printf "%-100s%s\n" "||                 $command" "||"
printf "%-100s%s\n" "||And my pid is $$, my name is $0" "||"
printf "%-100s%s\n" "||==================================================================================================" "||"
echo -e "\n"
}

CheckInput(){
case $1 in
	-h)
		echo "Usage: run_time_load.sh [day] [hour] [minute] [load] [command*]"
		echo "       run_time_load.sh [load] [command*]"
        	exit 0
		;;
	--help)
		_help_
        	exit 0
		;;
	[0-3][0-9])
		;;
	*)
		echo "Error: Invalid date input --- day!!!"
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
			echo "Error: Invalid date input --- $temp!!!"
			exit 1
			;;
	esac
done

load=$4
#load_max=2.5; load_min=0.8
if [[ `echo "$load <= $load_max && $load >= $load_min"|bc` -eq 0  ]]
then
        echo -e "Error: load must be $load_min or more and $load_max or less!!!"
        echo -e "       If the load is too high, it may lead to premature submission of tasks.\n"
        exit 1
fi

_day_=$1
_time_h_=$2
_time_m_=$3
#load_sleep=15
#_time_s_=$4
shift 4
command=$*
if [[ ! $command ]];then
	echo "Error: command is empty!!!"
	exit 1
fi
}

main(){

check_flag=0
load_max=2.5; load_min=0.3; load_sleep=15

if [[ $1 == [0-9]* && $2 && $2 != [0-9]* ]];then
	load=$1
	shift 1
	command=$*
	Start1
	CheckLoad
else	
	CheckInput $*
	Start
	CheckTime CheckLoad
fi

if [[ $check_flag == 0 ]];then
	echo "Everything is done, bye!"
	return 0
elif [[ $check_flag == 1 ]];then
	echo "Error: CheckLoad!!!"
	return 1
elif [[ $check_flag == 3 ]];then
	echo "Error: CheckTime!!!"
	return 1
fi

}

main $*
