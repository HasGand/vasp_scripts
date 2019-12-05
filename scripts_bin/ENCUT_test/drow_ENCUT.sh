#!/bin/bash
#grep "Total CPU" OUTCAR | awk '{print $6}'
#awk 'END {print}'
for i in * 
do
	if test -d $i
	then
		echo -e $i "," $(grep 'energy  without entropy' $i/OUTCAR | awk 'END {print}' | awk '{print $7}') >> /home/node/rjh/work/ZrS2/ZrS2_0%/EcutTest/Data_energy
		echo -e $i "," $(grep 'Total CPU' $i/OUTCAR | awk '{print $6}') >> /home/node/rjh/work/ZrS2/ZrS2_0%/EcutTest/Data_time
	fi
done

python3.6 drow_ENCUT.py
echo -e "\\n-----Great job!-----\\n"
