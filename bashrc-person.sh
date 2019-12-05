alias la='ls -la'
alias .='cd .. && ls'
alias ..='cd ../.. && ls'
alias ...='cd ../../.. && ls'
alias lsk='ls -l --block-size=K'
alias lsm='ls -l --block-size=M'
alias qsub='nohup mpirun -np 12 vasp_std &'
alias pos2pot='sed -n 6p POSCAR'
alias p4v="python2 /usr/bin/p4v.py"
alias catTS="grep 'entropy T' OUTCAR" ##电子熵
export PATH=/home/node/rjh/bin:$PATH

alias cdw="cd /home/node/rjh/work/"
alias rmall="rm CHG* IBZKPT DOSCAR OUTCAR OSZICAR PCDAT vasprun.xml REPORT EIGENVAL XDATCAR WAVECAR CONTCAR nohup.out"
#alias catrun="while [ $(awk 'END{print $1}' nohup.out) == "DAV:" ]; do echo "---------ok----------";break; done"
