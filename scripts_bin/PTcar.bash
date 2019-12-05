#!/usr/bin/bash

path=/home/node/software/vasp1/vasp.5.4.1/bin/PBE
#check if older version of POTCAR exist
if [ -f POTCAR ]; then
	mv -f POTCAR old-POTCAR
	echo "**Warning：old POTCAR file was found and renamed to be 'old-POTCAR'."
fi
#creat new POTCAR
for i in $*
do
	if test -f $path/$i/POTCAR; then
		cat $path/$i/POTCAR >> POTCAR
		echo "'$i'finished"
	elif test -f $path/$i/POTCAR.Z; then
		zcat $path/$i/POTCAR.Z >> POTCAR
		echo "'$i'finished"
	elif test -f $path/$i/POTCAR.gz; then
		gunzip -c $path/$i/POTCAR.gz >> POTCAR
		echo "'$i'finished"
	else 
		echo "**Warning: No suitable POTCAR for element '$i' was found!! Skip this element."
	fi
done
