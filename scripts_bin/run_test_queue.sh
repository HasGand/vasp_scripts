#!/usr/bin/sh
ch=1
while true
do
	rw_queue=$(awk -v ch=$ch 'NR==ch{for(i=2;i<=NF;i++){printf("%s ",$i)}}' rw_queue)
	rw_queue_path=$(awk -v ch=$ch 'NR==ch{print $1}' rw_queue)
	if [[ ! $rw_queue ]];then
                break
        fi
	######################
	printf %s "当前运行目录："
	cd $rw_queue_path
	pwd
	######################
	printf "%s %s" "当前运行任务：" "$rw_queue"
	echo `$rw_queue > rw_queue.out`
	wait
	######################
	printf %s "返回排队目录："
	cd -
	######################
	echo 
	ch=$[ $ch + 1 ]
	sleep 2
done
