pwd=${PWD}
out=${PWD}/outs
rm -rf $out
mkdir -p $out

cd dbgen

for i in {1..22}
do 
	./spark_wrapper.sh "./qgen -d -s 1 ${i}" ${out}/${i}.sql 
	diff ${pwd}/groundtruth_spark_queries/${i}.sql ${out}/${i}.sql 
done
