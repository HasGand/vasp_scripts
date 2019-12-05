#!/usr/bin/bash
##madebyrjh

if [ "$2" != "" ]
then
	sed -i "7s/@@/$2/g" $(which __js-Eads-on.py)
else
	sed -i "7s/@@\///g" $(which __js-Eads-on.py)
fi

sed -i "1,\$s/##/$1/g" $(which __js-Eads-on.py)
$(which python) $(which __js-Eads-on.py)
sed -i "1,\$s/$1/##/g" $(which __js-Eads-on.py)

if [ "$2" != "" ]
then
	sed -i "7s/$2/@@/g" $(which __js-Eads-on.py)
else
	sed -i "7s/lax/lax\/@@/g" $(which __js-Eads-on.py)
fi

