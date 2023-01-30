from pyspark import SparkFiles
from pyspark.sql import SparkSession

from constant import spark_inst

# spark = SparkSession.builder.appName("test").getOrCreate()

url = "https://data-science-electric-car.s3.eu-west-3.amazonaws.com/correspondance_code_insee_code_postal.csv"
# spark.sparkContext.addFile(url)
#
# df = spark.read.option("sep", "\t").csv("file://" + SparkFiles.get("clickstream-jawiki-2017-11.tsv.gz"))
# df.show(10)
#
#
# url = "https://opendata.reseaux-energies.fr/explore/dataset/eco2mix-national-tr/download/?format=csv"














import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark import SparkContext, SparkConf

import os
os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.3 pyspark-shell'

#spark configuration
conf = SparkConf().set('spark.executor.extraJavaOptions','-Dcom.amazonaws.services.s3.enableV4=true'). \
 set('spark.driver.extraJavaOptions','-Dcom.amazonaws.services.s3.enableV4=true'). \
 setAppName('pyspark_aws').setMaster('local[*]')

sc=SparkContext(conf=conf)
sc.setSystemProperty('com.amazonaws.services.s3.enableV4', 'true')

hadoopConf = sc._jsc.hadoopConfiguration()
hadoopConf.set('fs.s3a.endpoint', 's3-us-east-3.amazonaws.com')
hadoopConf.set('fs.s3a.impl', 'org.apache.hadoop.fs.s3a.S3AFileSystem')

spark=SparkSession(sc)


s3_df=spark.read.csv("s3://data-science-electric-car/correspondance_code_insee_code_postal.csv",header=True,inferSchema=True)
s3_df.show(5)

# df = spark.read.csv("s3://data-science-electric-car/correspondance_code_insee_code_postal.csv", header=True, inferSchema=True, sep=";")
