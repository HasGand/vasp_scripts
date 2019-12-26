#!/usr/bin/bash

$(which chgsum.pl) AECCAR0 AECCAR2
wait
$(which bader) CHGCAR -ref CHGCAR_sum
wait
$(which get_bader.py)
