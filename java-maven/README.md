# Quickstart for Java + Maven and Docker-compose

A sample application for using Rookout to debug a Java app built using Maven, and deployed using Docker Compose.

Before following this guide we recommend reading the basic [Java + Rookout] guide

* [Running locally](#running-locally)
* [Using docker compose](#using-docker-compose)
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

4. Make sure everything worked: [http://localhost:7000/](http://localhost:7000/hello)

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 



## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout to the original project by:
1. Adding your soruces to the project jar(`pom.xml`):
    ```xml
            <resources>
                <resource>
                    <directory>${basedir}/src/main/java</directory>
                </resource>
            </resources>
    ```
    
2. Downloading the Rookout Java Agent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
3. Specifying the Rookout Java Agent when running:
    ```bash
        java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar 
    ```

[Java + Rookout]: https://docs.rookout.com/docs/installation-java.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
