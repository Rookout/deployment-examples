from pyspark.sql.types import StructType, StructField, FloatType, StringType, IntegerType

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, udf

schema = StructType([
    StructField("partition", IntegerType()),
    StructField("lat", FloatType()),
    StructField("long", FloatType()),
    StructField("street_name", StringType()),
    StructField("building_no", IntegerType()),
    StructField("zip_code", StringType()),
    StructField("city", StringType()),
    StructField("state", StringType()),
    StructField("country", StringType())
])


def add_udf_column(points):
    def multiply_latlong(lat, long_):
        return int(lat) * int(long_)
    udf_multiply_latlong = udf(multiply_latlong, IntegerType())
    points = points.withColumn("multiplied_latlong", udf_multiply_latlong(col("lat"), col("long")))
    return points


def get_address_info(_):
    return {"street_name": "Bedford Ave",
            "building_no": 279,
            "zip_code": "11211",
            "city": "New York",
            "state": "NY",
            "country": "USA"}


def map_partitions_handler(records_iterator):
    records_with_address_info = []
    for record in records_iterator:
        record = record.asDict()
        record.update(get_address_info(record))
        records_with_address_info.append(record)
    return records_with_address_info


def main():
    import rook
    rook.start()

    spark_session = SparkSession.builder \
        .enableHiveSupport() \
        .getOrCreate()
    with open("sample-data.csv", "wb") as sample_data_file:
        sample_data_file.write("lat,long\n")
        for i in xrange(100000):
            sample_data_file.write("%d,40.714224,-73.961452\n" % (i % 10))
    points = spark_session.read.csv("sample-data.csv", header=True, schema=schema).repartition(10)
    points_rdd = points.rdd.mapPartitions(map_partitions_handler)
    points = spark_session.createDataFrame(data=points_rdd, schema=points.schema, verifySchema=False)
    points = add_udf_column(points)
    print points.take(1)


if __name__ == "__main__":
    main()
