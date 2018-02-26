# Quickstart for Java + Rookout and AWS Elastic Beanstalk

A sample application for using Rookout + Java + AWS Elastic Beanstalk .

Before following this guide we recommend reading the basic [Java + Rookout] guide

## Elastic Beanstalk Rookout Integration Explained

There are 2 simple steps to integrate Rookout into your existing java beanstalk application:

1. Add the source files to your built .jar

2. Add our 2 .ebextensions standalone config scripts
    * First one download and install the agent that is responsible for communication
    * Second one download and tells the JVM to use Rookout's java agent

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__


## Running locally
1. Run the Rookout agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
2. Compile the project jar and download the Java agent:
     ```bash
    $ make build
    ```
3. Run:
    ```bash
    $ make run
    ```

4. Make sure everything worked: [http://localhost:7000/?fname=rook&lname=out](http://localhost:7000/?fname=rook&lname=out)

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Running on AWS Elastic Beanstalk
1. Zip the project (the files, not the parent directory), use this command in the project directory to include all hidden files
    ```bash
    $ zip -r <DEST_FILE.zip> * .*
    ```

2. Upload the source bundle when creating a [new Beanstalk app](https://console.aws.amazon.com/elasticbeanstalk/home#/gettingStarted)

3. Choose 'Java' Platform

4. Upload the zip you previously archived in the base configuration part

5. Make sure everything worked by accessing the url provided by Elastic Beanstalk after build completed

6. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Rookout Integration Process
We have added Rookout to the original project by:
1. Adding sources to the project jar when building:
    ```bash
    jar cvfm target/server.jar Manifest.txt -C output/ . src/*
    ```

2. Adding Rookout's Elastic Beanstalk .ebextensions to install agent on machine and add the javaagent to communicate with the app:
    ```
    commands: 
        "01": 
            command: wget "https://get.rookout.com" -O setup.sh
        "02": 
            command: sudo /bin/bash setup.sh agent --token=<YOUR_TOKEN>
        "03": 
            command: /etc/init.d/rookout-agent start
    ```
    ```
    files:
        "/opt/elasticbeanstalk/lib/rook.jar" :
            mode: "000444"
            owner: root
            group: root
            source: "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"
    option_settings:
        aws:elasticbeanstalk:application:environment:
            JAVA_TOOL_OPTIONS: '-javaagent:/opt/elasticbeanstalk/lib/rook.jar'
    ```

[Java + Rookout]: https://rookout.github.io/tutorials/java
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook