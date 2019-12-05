#!/usr/bin/python3
import matplotlib.pyplot as plt
import numpy as np
ecut,time = np.loadtxt("Data_time", delimiter=",").transpose()
ecut,energy = np.loadtxt("Data_energy", delimiter=",").transpose()

plt.subplot(1,9,(1,4))
plt.scatter(ecut, time)
plt.plot(ecut, time)
plt.xlabel("ENCUT")
plt.ylabel("TIME")

plt.subplot(1,9,(6,9))
plt.scatter(ecut, energy)
plt.plot(ecut,energy)
plt.xlabel("ENCUT")
plt.ylabel("ENERGY")

plt.savefig("ENCUT-ENERGY-TIME", dpi=1000)
plt.show()
