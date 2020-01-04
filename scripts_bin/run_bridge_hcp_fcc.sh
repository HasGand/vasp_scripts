#!/usr/bin/bash
echo -e "\n"
printf "%-100s%s\n" "||==================================================================================================" "||"
printf "%-100s%s\n" "||My pid is $$, and my name is $0" "||"
printf "%-100s%s\n" "||==================================================================================================" "||"
echo -e "\n"

if [ -d top ]
then
	echo "Let's run!"
else
	echo "The files needed don't exiest."
	exit
fi

cp top/INCAR top/POTCAR top/KPOINTS bridge
cp top/INCAR top/POTCAR top/KPOINTS hcp
cp top/INCAR top/POTCAR top/KPOINTS fcc

cd bridge
mpirun -np 48 vasp_std >> nohup.out
wait
cd ../hcp
mpirun -np 48 vasp_std >> nohup.out
wait
cd ../fcc
mpirun -np 48 vasp_std >> nohup.out
wait
cd ..

for i in 1 2
do
	cd bridge
	cp CONTCAR POSCAR
	mpirun -np 48 vasp_std >> nohup.out
	wait
	cd ../hcp
	cp CONTCAR POSCAR
	mpirun -np 48 vasp_std >> nohup.out
	wait
	cd ../fcc
	cp CONTCAR POSCAR
	mpirun -np 48 vasp_std >> nohup.out
	wait
	cd ..
done

cd ~/rjh/work/2-ZrS2
##输入气体参数
Eads-select-on.sh $1 bridge
mv Eads-$1 Eads-$1-bridge
wait
Eads-select-on.sh $1 hcp
mv Eads-$1 Eads-$1-hcp
wait
Eads-select-on.sh $1 fcc
mv Eads-$1 Eads-$1-fcc
wait
for i in Eads-$1-*
do
	echo "$i $(awk 'END{print }' $i)" >> Eads-$1
done

rm -f Eads-$1-*
mv Eads-$1 Eads
wait

echo "The task of relax(+$1) is finished!" >> ~/rjh/work/task.file
