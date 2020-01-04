#!/home/mechine4/software/Python-3.6.2/build/bin/python3
#Get lattice paramters from BM state equation

import math
import numpy as np

print(	"\nWarning!!!"
	"\nRemember to change a*2.8664 in x"
	"\nto your own lattice parameters before use it!\n")

a, E = np.loadtxt('data', usecols=(0,1), delimiter='\t', unpack=True)
x = (a*2.8664)**(-2)
p = np.polyfit(x, E, 3)
c0 = p[3]
c1 = p[2]
c2 = p[1]
c3 = p[0]
x1 = (math.sqrt(4*c2**2 - 12*c1*c3)-2*c2) / (6*c3)
para = 1/math.sqrt(x1)
print("The final lattice parameter is: %s " %(para))
