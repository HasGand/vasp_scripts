#!/usr/bin/bash

for i in *
do cd $i
nohup mpirun -np 4 vasp_std &
cd $OLDPWD
done
