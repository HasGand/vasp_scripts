#/usr/bin/python
# -*- coding: UTF-8 -*- 
import requests
def bc(ename):
	with open(path, 'wb') as f:
		f.write(r.content)
		f.close()
		print("{}.psf保存成功!".format(ename))
ele = raw_input("请输入元素种类:")
for i in ele.split():
	url="https://departments.icmab.es/leem/siesta/Databases/Pseudopotentials/Pseudos_GGA_Abinit/{}_html/{}.psf".format(i,i)
	pic_name = url.split('/')[-1]
	path = pic_name
	r = requests.get(url)
	bc(i)
