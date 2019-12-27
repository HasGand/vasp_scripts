#!/usr/bin/bash
#madebyrjh
#The files needed are _left.fdf_ ; _right.fdf_ ; scat.fdf ; tbtrans.fdf ; right.fdf ; left.fdf ; positions.fdf ; *.psf

mkdir doc left right
#修改左右电极原子数
sed -i "39s/_number_/$(awk 'NR==26{printf("%d",$2)}' left.fdf)/g" scat.fdf
sed -i "40s/_number_/$(awk 'NR==26{printf("%d",$2)}' right.fdf)/g" scat.fdf
sed -i "8s/_number_/$(awk 'NR==26{printf("%d",$2)}' left.fdf)/g" tbtrans.fdf
sed -i "9s/_number_/$(awk 'NR==26{printf("%d",$2)}' right.fdf)/g" tbtrans.fdf
#修改PDOS
sed -i "25s/_number_/$(awk 'NR==26{printf("%d",1+$2)}' left.fdf)/g" tbtrans.fdf
left_num=$(awk 'NR==26{printf("%d",$2)}' left.fdf)
posi_num=$(awk 'NR==26{printf("%d",$2)}' positions.fdf)
sum=$(($left_num+$posi_num))
sed -i "26s/_number_/$sum/g" tbtrans.fdf
#doc文件夹ok
mv positions.fdf *.psf tbtrans.fdf scat.fdf doc
#加入left的赝势文件
for i in $(num=$(awk 'NR==25{print $2}' left.fdf); awk -v num="$num" 'NR>=29&&NR<=((28+num)){printf("%4s",$3)}' left.fdf); do echo $i >> data;done
for i in $(sed "s/\r/\n/g" data); do cp doc/$i.psf left;done
rm data
#加入right的赝势文件
for i in $(num=$(awk 'NR==25{print $2}' right.fdf); awk -v num="$num" 'NR>=29&&NR<=((28+num)){printf("%4s",$3)}' right.fdf); do echo $i >> data;done
for i in $(sed "s/\r/\n/g" data); do cp doc/$i.psf right;done
rm data
#修改left头名 加入计算参数
hl=$(expr $(echo `cat left.fdf | wc -l`) - 3)
sed -i "6,7s/VNL-Export/left/g" left.fdf
sed -i "${hl}r _left.fdf_" left.fdf
#修改right头名 加入计算参数
hr=$(expr $(echo `cat right.fdf | wc -l`) - 3)
sed -i "6,7s/VNL-Export/right/g" right.fdf
sed -i "${hr}r _right.fdf_" right.fdf
#left right文件夹ok
mv left.fdf left
mv right.fdf right
#移除准备文件
rm _left.fdf_ _right.fdf_
