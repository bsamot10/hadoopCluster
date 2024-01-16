from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
df = spark.read.option("header", "true").csv("hdfs:///data.csv")
df.show()
