#!/usr/bin/bash
### or -> /usr/bin/env bash
echo K-POINTS > KPOINTS
echo 0 >> KPOINTS
echo $1 >> KPOINTS
echo $2 $3 $4 >> KPOINTS
echo 0 0 0 >> KPOINTS
echo "Finshed!"
