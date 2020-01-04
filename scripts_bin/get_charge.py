#!/home/mechine4/software/Python-3.6.2/build/bin/python3
##madebyrjh
import numpy as np
import os
#os.system("cow=$(sum=2; for i in $(awk 'NR==7{print }' POSCAR); do ((sum+=$i)); done; echo $sum);echo $(awk -v cow=\"$cow\" 'NR>=3 && NR<=cow{print $5}' ACF.dat) > temp")
os.system("echo $(cow=$(awk 'NR==7{sum=2; for(i=1;i<=NF;i++){sum+=$i}{print sum}}' POSCAR); awk -v cow=\"$cow\" 'NR>=3&&NR<=cow{print $5}' ACF.dat) > temp")
#os.system("echo $(awk '{printf("%f\n", $5)}' ACF.dat | awk '{for(i=1;i<=NR;i++){if($i!=0){print $i}}}') > temp") 转义问题难以解决
CHARGE = np.loadtxt("temp")
os.system("echo $(grep ZVAL POTCAR | awk '{print $6}') > temp")
ZvalTemp = np.loadtxt("temp")
os.system("echo $(awk 'NR==7{print }' POSCAR) > temp")
Num = np.loadtxt("temp")
os.system("rm temp")
##给ZVAL扩容
ZVAL = []

sort = []
for i in range( int(sum(Num)) ):
	sort.append(i+1)

for i in range(len(Num)):
	for j in range(int(Num[i])):
		ZVAL.append(ZvalTemp[i])
ZVAL = np.array(ZVAL)
deta = CHARGE - ZVAL
data = [sort, CHARGE, ZVAL, deta]
data = np.array(data)
np.savetxt("data_charge", data.transpose(), fmt="%15.4f")
with open('data_charge', 'r+') as f:
    content = f.read()
    f.seek(0, 0)
    f.write('\t  order\t\t CHARGE    -\t ZVAL\t=  Electronic gain and loss\n'+content)
print("已生成data_charge文件!")
