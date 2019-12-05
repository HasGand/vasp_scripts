#!/usr/bin/python3
#madebyrjh
import numpy as np
import os

os.system("if [ -f Eads-## ];then mv Eads-## Eads-##-old; echo 'the old file exists! rm it? [y/n]';fi")
key1 = input("Hello: ")
if key1=='y':
	os.system("rm Eads-##-old")
os.system("for i in 1* q*##;do echo $(grep sigma $i/relax/OUTCAR | awk 'END{print $7}');done >> Eads-##")
os.system("echo $(grep sigma *_*##/relax/@@/OUTCAR | awk 'END{print $7}') >> Eads-##")
slab, gas, sg = np.loadtxt("Eads-##").transpose()
Eads = sg - slab - gas
print("\nEads(##) = {}\n".format(Eads))
sj=[slab, gas, sg, Eads]
np.savetxt("Eads-##", sj)
print("已生成Eads-##文件，依次为slab  slab+## Eads(##)")

print("rm Eads-##??? [y/n]")
key2 = input()
if key2=='y':
	os.system("rm Eads-##")
