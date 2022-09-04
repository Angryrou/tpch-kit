out=${PWD}/outs
rm -rf $out
mkdir -p $out

export DSS_CONFIG=$PWD/dbgen
export DSS_QUERY=${DSS_CONFIG}/queries_sparksql

for i in {1..22}
do 
	dbgen/spark_wrapper.sh "qgen -d -s 1 ${i}" ${out}/${i}.sql 
	diff $PWD/groundtruth_spark_queries/${i}.sql ${out}/${i}.sql 
done
