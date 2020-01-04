#!/usr/bin/bash
##准备SCF 和其余各文件的INCAR_?
echo -e "\n"
printf "%-100s%s\n" "||==================================================================================================" "||"
printf "%-100s%s\n" "||My pid is $$, and my name is $0" "||"
printf "%-100s%s\n" "||==================================================================================================" "||"
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
