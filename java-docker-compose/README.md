# Quickstart for Java + Rookout and Docker-compose

A sample application for using Rookout + Java(Maven/Gradle) + Docker-compose .

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
    $ make build-local-maven
    ```
    Or:
     ```bash
    $ make build-local-gradle
    ```
3. Run:
    ```bash
    $ make run-local-maven
    ```
    Or:
    ```bash
    $ make run-local-gradle
    ```    
4. Make sure everything worked: [http://localhost:7000/hello](http://localhost:7000/hello)


## Using docker compose

1. Compile the project jar:
     ```bash
    $ make build
    ```
2. Edit docker-compose.yaml and add your token
    ``` YAML
        environment:
          ROOKOUT_TOKEN: YOUR_TOKEN_HERE
    ```
3. Build the image
    ``` bash
    $ docker-compose build
    
    ```
4. Run:
    ```bash
    $ docker-compose up
    ```
5. Make sure everything worked: [http://localhost:7000/hello](http://localhost:7000/hello)

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout to original project by:
1. Adding soruces to the project jar(`pom.xml`):
    ```xml
            <resources>
                <resource>
                    <directory>${basedir}/src/main/java</directory>
                </resource>
            </resources>
    ```
    If you build using gradle (`build.gradle`):
    ```properties
    jar {
        from sourceSets.main.allSource
    }
    ```
2. Download javaagent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
3. Specified the javaagent when running:
    ```bash
        java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar 
    ```
    Or:
    ```bash
        java  -javaagent:rook.jar -jar build/libs/rookoutDemo-1.0.0.jar
    ```
    
4. Changing the `ROOKOUT_TOKEN` on `docker-compose.yaml`:
    ``` YAML
        environment:
          ROOKOUT_TOKEN: YOUR_TOKEN_HERE
    ```

[Java + Rookout]: https://rookout.github.io/tutorials/java
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook