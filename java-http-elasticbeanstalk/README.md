# Quickstart for Java + Rookout and AWS Elastic Beanstalk

A sample application for using Rookout + Java + AWS Elastic Beanstalk .

Before following this guide we recommend reading the basic [Java + Rookout] guide

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)
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
1. Zip the project (the files, not the parent directory)

2. Upload the source bundle when creating a new Beanstalk app

3. Choose 'Java' Platform

4. Make sure everything worked by accessing the url at port 7000 provided by Elastic Beanstalk after build completed

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Rookout Integration explained

We have added Rookout to the original project by:
1. Adding sources to the project jar when building:
    ```bash
    jar cvfm target/server.jar Manifest.txt -C output/ . src/*
    ```
    
2. Downloading rook javaagent available on [maven central]:
    ```bash
    wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```

3. Specifying the javaagent when running:
    ```bash
    java  -javaagent:rook.jar -jar target/server.jar 
    ```

4. Elastic Beanstalk .ebextensions to install agent on machine:
    ```
    commands: 
        "01": 
            command: wget "https://get.rookout.com" -O setup.sh
        "02": 
            command: sudo setup.sh agent --token <YOUR_TOKEN_HERE>
        "03": 
            command: /etc/init.d/rookout-agent start
    ```

[Java + Rookout]: https://rookout.github.io/tutorials/java
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook