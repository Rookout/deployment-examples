from flask import Flask
from pyspark.sql import SparkSession
import rook

import driver


app = Flask(__name__)
spark = SparkSession.builder.appName('Sample Spark App').getOrCreate()
sc = spark.sparkContext


@app.route('/driver')
def driver_handler():
    driver_instance = driver.DriverClass(sc)
    res = driver_instance.run_driver()
    return str(res)


if __name__ == '__main__':
    rook.start()
    app.run(host='0.0.0.0', port=4000, threaded=True)
