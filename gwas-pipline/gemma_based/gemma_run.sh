bed_file="355_ms_0.4"
rel_ma="355_ms_0.4.cXX.txt"
num="21"
for i in `seq 1 ${num}`
do
echo $i
~/myprogram/bio-tool/gemma -bfile  ${bed_file} -k ${rel_ma} -lmm 1 -n ${i} -o ${i} ||exit 0
done

