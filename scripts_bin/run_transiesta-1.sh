#!/bin/bash
#依次输入 计算核数 结构名称 各电压值
path="/home/node/software/mpich/mpich/bin"
echo    ""
echo -e "|----------------------------------------------------------------------------------------------|"
echo    "|                                Welcome to use $0.                                            |"
echo -e "|	    You have submitted $((($#-2))) tasks!\nThe parameters you enter are ( $* ).         |"
echo -e "|The task number for this script is $$.\nYou can kill this IV-work.sh through the task number!.|"
echo -e "|----------------------------------------------------------------------------------------------|\n\n"

for i in $*
do

if [ $i == $1 ]
then
        continue
fi
if [ $i == $2 ]
then
        continue
fi

mkdir $i
cd $i
cp ../doc/* .
cat >>  tbtrans.fdf <<  !
TS.Voltage  $i ev
!
cat >>  scat.fdf <<  !
TS.Voltage  $i ev
!
$path/mpirun -np $1 transiesta < scat.fdf > scat-$i.out
wait
cp $2.TSDE ../doc
mkdir tbtrans
cp positions.fdf $2.TSHS tbtrans.fdf tbtrans
cd tbtrans
$path/mpirun -np $1 tbtrans < tbtrans.fdf > tbtrans-$i.out
wait
grep 'Voltage, Current(A)' tbtrans-$i.out >> ../../IV.txt
cd ../..
done
