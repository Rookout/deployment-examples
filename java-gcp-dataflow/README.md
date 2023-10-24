# Quickstart for Dataflow + Google Cloud Platform

A sample application for using Rookout API to debug a Java app built using Maven.

Before following this guide we recommend completing the basic [Java + Rookout tutorial](https://github.com/Rookout/tutorial-java).

## Rookout Integration explained

This example is based of the Java word-count-beam example available [here].

1. Before executing the pipeline run [here](https://beam.apache.org/get-started/wordcount-example/#:~:text=section%2C%20MinimalWordCount.-,To%20run%20this%20example%20in%20Java,-%3A), export Rookout Environmnet variables:
    ```xml
        export ROOK_AGENT_JAR="/YourPath/rook.jar"
    ```
    ```xml
        export JAVA_TOOL_OPTIONS="-javaagent:$ROOK_AGENT_JAR -DROOKOUT_TOKEN=<Your_Token>"
    ```


2. Deploy your app and go to [http://app.rookout.com](http://app.rookout.com) and start debugging!

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://beam.apache.org/get-started/wordcount-example/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
