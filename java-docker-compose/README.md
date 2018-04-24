# Quickstart for Java + Rookout and Docker-compose

A sample application for using Rookout + Java(Maven/Gradle) + Docker-compose .

Before following this guide we recommend reading the basic [Java + Rookout] guide 

* [Using docker compose](#using-docker-compose)
* [Rookout Integration explained](#rookout-integration-explained)

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

6. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 
## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout to the original project by:
1. Adding soruces to the project jar(`pom.xml`):
    ```xml
            <resources>
                <resource>
                    <directory>${basedir}/src/main/java</directory>
                </resource>
            </resources>
    ```
    
2. Download javaagent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
    
3. Changing the `ROOKOUT_TOKEN` on `docker-compose.yaml`:
    ``` YAML
        environment:
          ROOKOUT_TOKEN: YOUR_TOKEN_HERE
    ```    
    
3. Specified the javaagent when running:
    ```bash
        java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar 
    ```


[Java + Rookout]: https://docs.rookout.com/docs/installation-java.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
