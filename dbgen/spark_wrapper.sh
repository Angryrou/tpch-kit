cmd=$1
fpth=$2

export DSS_CONFIG=$PWD
export DSS_QUERY=${DSS_CONFIG}/queries_sparksql

$cmd | sed 's/;//' > $fpth