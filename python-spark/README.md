
# Quickstart for debugging PySpark applications

A sample application for debugging Python Spark apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

## Running PySpark jobs with Rookout

1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/python-spark
    pip install -r requirements.txt  # also on executor nodes, if running in a cluster
```

2. *Export organization token*:
 ```
 export ROOKOUT_TOKEN=<Your Rookout Token>
```

3. 

#### Usage example
Try placing breakpoints at these locations in `example.py`:
* In `main` on line 65
* In `map_partitions_handler` on line 48
* In `multiply_latlong` (a UDF) on line 24
* Run your program


4. *Use `spark-submit` to submit the job while loading Rookout into Spark executors (Spark standalone)*:
```
spark-submit --conf spark.python.daemon.module=rook.pyspark_daemon example.py
```


5. *Have fun debugging*:
	Go to https://app.rookout.com and start debugging :)
	


## Running under YARN (AWS EMR)
1. Upload the `sample-data.csv` file to a S3 bucket, and modify the code so it calls `spark_session.read.csv` with `s3a://bucket-name/sample-data.csv` for the path, where `bucket-name` is replaced by the bucket that contains your uploaded file.
2. Specify the `ROOKOUT_TOKEN` environment variable:

```
spark-submit --conf spark.python.daemon.module=rook.pyspark_daemon --conf spark.yarn.appMasterEnv.ROOKOUT_TOKEN=[Your Rookout Token]` `--conf spark.executorEnv.ROOKOUT_TOKEN=[Your Rookout Token] example.py
```


    
## Rookout Integration explained
1. Rookout is loaded into the Spark driver on line 74 in main.py, by calling `rook.start()` directly. This is the standard way of loading Rookout, but we still haven't loaded Rookout into the executor nodes.

2. Specifying the configuration option `--conf spark.python.daemon.module=rook.pyspark_daemon` loads Rookout into the executor nodes. When specifying this option, Rookout will automatically load to worker processes. This is necessary for placing breakpoints in any code that runs on executor nodes.

[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

