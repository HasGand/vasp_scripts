#!/bin/bash
#依次输入 计算核数 结构名称 各数据
path="/home/node2/software/mpich/mpich/bin"
echo "Welcome to use $0."
echo -e "You have submitted $((($#-2))) tasks!\nThe parameters you enter are ( $* )."
echo -e "The task number for this script is $$.\nYou can kill this IV-work.sh through the task number!.\n\n"
sed -i "1,\$s/##/$2/g" doc/scat.fdf doc/tbtrans.fdf
cd left
$path/mpirun -np $1 transiesta < left.fdf > left.out
wait
cp left.TSHS ../doc
cd ../right
$path/mpirun -np $1 transiesta < right.fdf > right.out
wait
cp right.TSHS ../doc
cd ..
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

