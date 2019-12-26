#!/usr/bin/bash
##准备SCF 和其余各文件的INCAR_?
echo ""
echo -e "|-----------------------------------------------------------------------------------------|"
echo -e "|		(*^_^*)The task number for this script is $$.	                	|"
echo -e "|		You can kill the $0 through the task number!.(￣y▽,￣)╭ 	       |"
echo -e "|-----------------------------------------------------------------------------------------|"
echo -e "\n"

if [ -d SCF ]
then
	echo "OK, let's run!"
else
	echo "The files needed don't exist."
	exit
fi

cd SCF
mpirun -np 48 vasp_std >> nohup.out
wait

cd ../DOS
cp ../SCF/* .
rm nohup.out INCAR
mv INCAR_DOS INCAR
mpirun -np 48 vasp_std >> nohup.out
wait

cd ../charge
cp ../SCF/* .
rm nohup.out INCAR
mv INCAR_charge INCAR
mpirun -np 48 vasp_std >> nohup.out
wait

cd ../bader
cp ../SCF/* .
rm nohup.out INCAR
mv INCAR_bader INCAR
mpirun -np 48 vasp_std >> nohup.out
wait

cd ..

cd bader
$(which bader.sh)
cd ../DOS
echo 111 | vaspkit
$(which TDOS_plot.py)
