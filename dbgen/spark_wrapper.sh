cmd=$1
fpth=$2

${DSS_CONFIG}/$cmd | sed 's/;//' > $fpth