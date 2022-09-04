Additional parts in tpch-kit
============================

Before reading this README, please check the orignial one at [here][1].

[1]: README_ori.md


<!--ts-->
* [Spark SQL](#spark-sql)
  * [Query Template Modification for SparkSQL](#query-template-modification-for-sparksql)
  * [Query Generation for SparkSQL](#query-generation-for-sparksql)
  * [Query Verificaiton](#query-verification)
<!--te-->


SparkSQL
========

Query Template Modification for SparkSQL
----------------------------------------
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
  ```

Query Generation for SparkSQL
-----------------------------

Step1: set the env variables for `DSS_CONFIG` and `DSS_QUERY`

Step2: use the `dbgen/spark_wrapper.sh` to feed (1) the original `qgen` command, (2) the path of the output

  ```bash
  export DSS_CONFIG=$PWD/dbgen
  export DSS_QUERY=${DSS_CONFIG}/queries_sparksql
  dbgen/spark_wrapper.sh "qgen -d -s 1 1" out/1.sql 
  ```

Query Verification
------------------

We align our query to the TPCH query from the databricks's `spark-sql-perf` at `src/main/resources/tpch/queries`
  ```bash
  bash validate_sparksql_gen.sh # output nothing when validated.
  ```
