import time
from pyspark.sql.types import StructType, StructField, FloatType, StringType, IntegerType
from pyspark.sql.functions import col, udf


def multiply_latlong(lat, long_):
    print "multiply_latlong executed"
    res = int(lat) * int(long_)
    time.sleep(1)
    return res


def add_udf_column(points):
    udf_multiply_latlong = udf(multiply_latlong, IntegerType())
    points = points.withColumn("multiplied_latlong", udf_multiply_latlong(col("lat"), col("long")))
    return points


class AddressInfoGetter(object):
    def get_address_info(self, _):
        return {"street_name": "Bedford Ave",
                "building_no": 279,
                "zip_code": "11211",
                "city": "New York",
                "state": "NY",
                "country": "USA"}


def handle_record(record):
    print "handle_record executed"
    record = record.asDict()
    time.sleep(1)
    getter = AddressInfoGetter()
    record.update(getter.get_address_info(record))
    return record


def map_partitions_handler(records_iterator):
    records_with_address_info = []
    for record in records_iterator:
        records_with_address_info.append(handle_record(record))
    return records_with_address_info
