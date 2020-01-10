#!/usr/bin/sh
queue_path=$(awk 'NR==1{print $1}' rw_queue)
load=$(awk 'NR==1{print $2}' rw_queue)
load_sleep=$(awk 'NR==1{print $3}' rw_queue)
rw_finished_num=0
echo -e "\n\t\b\b---该程序本次运行-完成的任务情况---"  >> $queue_path/rw_finished

printf "%-75s%s\n" "||=========================================================================" "||"
printf "%-75s%s\n" "||PID: $$     NAME: $0" "||"
printf "%-75s%s\n" "||=========================================================================" "||"
echo -e "\n"

CheckLoad(){
while true
do
        if [[ `echo "$(uptime |awk '{printf("%f",$(NF-1))}') < $load" |bc` -eq 1 ]]
        then
                printf "%s" "load < $load 开始执行当前任务..."
                echo `$rw >> $out_file`
		wait
                return 0
        fi
        sleep ${load_sleep}
done
return 1
}

while true
do
	rw=$(awk 'NR==2{for(i=2;i<NF;i++){printf("%s ",$i)}}' $queue_path/rw_queue)
	if [[ ! $rw ]];then
		echo -e "当前无任务...\n"
                while true
		do
			sleep 10
			rw=$(awk 'NR==2{for(i=2;i<NF;i++){printf("%s ",$i)}}' $queue_path/rw_queue)
			if [[ $rw ]];then
				break
			fi
		done
        fi
	rw_path=$(awk 'NR==2{print $1}' $queue_path/rw_queue)
	out_file=$(awk 'NR==2{print $NF}' $queue_path/rw_queue)
	######################
	echo -e   "=========================================================="
	printf %s "进入运行目录："
	cd $rw_path
	pwd
	######################
	printf "%s %s" "当 前 任 务 ：" "$rw"
	echo -e "\n等待其他任务完成..."
	CheckLoad
	wait
	echo -e "当前任务已完成..."
	rw_finished_num=$[$rw_finished_num + 1]
	rw_finished=$(awk 'NR==2{print }' $queue_path/rw_queue)
	sed -i "2d" $queue_path/rw_queue
	printf "[%d] " $rw_finished_num  >> $queue_path/rw_finished
	echo $rw_finished >> $queue_path/rw_finished
	######################
	printf %s "返回任务队列目录："
	cd -
	######################
	echo -e   "==========================================================\n"
	sleep 2
done
