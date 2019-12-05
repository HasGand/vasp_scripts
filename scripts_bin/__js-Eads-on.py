#!/usr/bin/python3.6
#madebyrjh
import numpy as np
import os

os.system("for i in 1* q*##;do echo $(grep sigma $i/relax/OUTCAR | awk 'END{print $7}');done >> Eads-##")
os.system("echo $(grep sigma *_*##/relax/@@/OUTCAR | awk 'END{print $7}') >> Eads-##")
slab, gas, sg = np.loadtxt("Eads-##").transpose()
Eads = sg - slab - gas
sj=[slab, gas, sg, Eads]
np.savetxt("Eads-##", sj)
