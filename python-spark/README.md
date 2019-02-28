
# Quickstart for debugging PySpark applications

A sample application for debugging Python Spark apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

## Running PySpark jobs with Rookout

1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples/tree/master/python-spark
    pip install -r requirements.txt  # also on executor nodes, if running in a cluster
```

2. *Export organization token*:
 ```
 export ROOKOUT_TOKEN=<Your Rookout Token>
```

3. *Use `spark-submit` to submit the job while loading Rookout into Spark executors*:
```
    spark-submit --conf spark.python.daemon.module=rook.pyspark_daemon example.py
```

4. *Enjoy the debugging*:
	Go to https://app.rookout.com and start debugging :)
	
	Try placing breakpoints: In `example.py`, `main` will run in the Spark driver, while `map_partitions_handler` and `multiply_latlong` (a UDF) 
will run on executor nodes.

    To try this application with a YARN (potentially AWS EMR) cluster, try uploading a sample data CSV formatted like so:
    ```0,lat,long```
    to S3, and calling `spark_session.read.csv` with `s3a://bucket-name/sample-data.csv` for the path, where `bucket-name` is replaced by the bucket that contains your uploaded file.

## Rookout Integration explained
Several separate Python processes work in tandem to complete a Spark job.
- In `--deploy-mode client`, the Spark driver (which runs `example.py`) runs locally, on the system that executed `spark-submit`.
- In `--deploy-mode cluster`, the Spark driver runs as part of the cluster. In a YARN cluster, it runs on the ApplicationMaster for your job.

To place Rookout breakpoints in code that runs in the Spark driver, you must start Rookout in your Spark driver code. Note how the beginning of `main` in `example.py` imports `rook` and calls `rook.start()`.

Processing code (mapPartitions, Spark UDFs) runs on executor nodes. Spark allows you to specify the Python module
responsible for starting the Python worker processes on executor nodes. The configuration option `--conf spark.python.daemon.module=rook.pyspark_daemon` accomplishes this task.

When specifying this option, Rookout will automatically load to worker processes. This is necessary for placing breakpoints in any code that runs on executor nodes.

In `example.py`, `main` will run in the Spark driver, while `map_partitions_handler` and `multiply_latlong` (a UDF) 
will run on executor nodes.

[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

