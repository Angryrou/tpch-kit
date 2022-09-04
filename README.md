tpch-kit-spark
========

This version is based on `https://github.com/gregrahn/tpch-kit` and has modified to:
  * support SparkSQL generation based on `dbgen/wrapper_spark.sh` 
    ```bash
      with the following changes:
      * "first -1" removed
      * "first N" changed to "limit N"
      * ; (semicolon) at end of queries removed
      * Q1: "interval '90' day (3)" changed to "interval '90' day"
      * Q7, Q8, Q9: "extract(year from X)" changed to "year(X)"
      * Q13: "as c_orders (c_custkey, c_count)" changed to "c_orders" and c_count alias moved inside subquery
      * Q15: CREATE VIEW changed to WITH
      * Q22: "substring(c_phone from 1 to 2)" changed to "substring(c_phone, 1, 2)"
    ````
  * add sparksql groundtruth and validation function for the query generation.
    ```bash
      # an example for query generation
      export DSS_CONFIG=$PWD/dbgen
      export DSS_QUERY=${DSS_CONFIG}/queries_sparksql
      dbgen/spark_wrapper.sh "qgen -d -s 1 1" outs/1.sql 

      # to validate all
      bash validate_sparksql_gen.sh
    ```


README from Gregrahn's
==========

TPC-H benchmark kit with some modifications/additions

Official TPC-H benchmark - [http://www.tpc.org/tpch](http://www.tpc.org/tpch)

## Modifications

The following modifications have been added on top of the official TPC-H kit:

* modify `dbgen` to not print trailing delimiter
* add option for `dbgen` to output to stdout
* add compile support for macOS
* add define for PostgreSQL to support `LIMIT N` for `qgen`
* adjust `Makefile` defaults

## Setup

### Linux

Make sure the required development tools are installed:

Ubuntu:
```
sudo apt-get install git make gcc
```

CentOS/RHEL:
```
sudo yum install git make gcc
```

Then run the following commands to clone the repo and build the tools:

```
git clone https://github.com/gregrahn/tpch-kit.git
cd tpch-kit/dbgen
make MACHINE=LINUX DATABASE=POSTGRESQL
```

### macOS

Make sure the required development tools are installed:

```
xcode-select --install
```

Then run the following commands to clone the repo and build the tools:

```
git clone https://github.com/gregrahn/tpch-kit.git
cd tpch-kit/dbgen
make MACHINE=MACOS DATABASE=POSTGRESQL
```

## Using the TPC-H tools

### Environment

Set these env variables correctly:

```
export DSS_CONFIG=/.../tpch-kit/dbgen
export DSS_QUERY=$DSS_CONFIG/queries
export DSS_PATH=/path-to-dir-for-output-files
```

### SQL dialect

See `Makefile` for the valid `DATABASE` values.  Details for each dialect can be found in `tpcd.h`.  Adjust the query templates in `tpch-kit/dbgen/queries` as need be.

### Data generation

Data generation is done via `dbgen`.  See `dbgen -h` for all options.  The environment variable `DSS_PATH` can be used to set the desired output location.

### Query generation

Query generation is done via `qgen`.  See `qgen -h` for all options.

The following command can be used to generate all 22 queries in numerical order for the 1GB scale factor (`-s 1`) using the default substitution variables (`-d`).

```
qgen -v -c -d -s 1 > tpch-stream.sql
```

To generate one query per file for SF 3000 (3TB) use:

```
for ((i=1;i<=22;i++)); do
  ./qgen -v -c -s 3000 ${i} > /tmp/sf3000/tpch-q${i}.sql
done
```
