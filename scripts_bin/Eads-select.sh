#!/usr/bin/bash
##madebyrjh
#if [ "$1" == "NO" ] ##计算完之前，数据位置不同
#then
	#sed -i "1,\$s/7/8/g" $(which __js-Eads.py)
#fi

if [ "$2" != "" ]
then
	sed -i "11s/@@/$2/g" $(which __js-Eads.py)
else
	sed -i "11s/@@\///g" $(which __js-Eads.py)
fi

sed -i "1,\$s/##/$1/g" $(which __js-Eads.py)
$(which python) $(which __js-Eads.py)
sed -i "1,\$s/$1/##/g" $(which __js-Eads.py)

if [ "$2" != "" ]
then
	sed -i "11s/$2/@@/g" $(which __js-Eads.py)
else
	sed -i "11s/lax/lax\/@@/g" $(which __js-Eads.py)
fi

#if [ "$1" == "NO" ]
#then
	#sed -i "1,\$s/8/7/g" $(which __js-Eads.py)
#fi
