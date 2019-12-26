#!/usr/bin/bash
### or -> /usr/bin/env bash
echo K-POINTS > KPOINTS
echo 0 >> KPOINTS
echo Gamma >> KPOINTS
echo $1 $2 $3 >> KPOINTS
echo 0 0 0 >> KPOINTS
echo "Finshed!"
