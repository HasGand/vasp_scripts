#!/usr/bin/python3
import matplotlib.pyplot as plt
import numpy as np
x,y = np.loadtxt('data.dat', delimiter = ',', usecols=(0,1), unpack=True)
plt.xlabel('ENCUT / ev')
plt.ylabel('Time / s')
plt.plot(x,y, 'rs-', linewidth=2.0)
plt.show()
