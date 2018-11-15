# Quickstart for Java + Maven and Docker-compose

A sample application for using Rookout to debug a Java app built using Maven, and deployed using Docker Compose.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

* [Running locally](#running-locally)
* [Using docker compose](#using-docker-compose)
* [Rookout Integration explained](#rookout-integration-explained)
## Running locally
1. Clone and compile the project jar and download the Java agent:
     ```bash
    $ git clone https://github.com/Rookout/deployment-examples/tree/master/java-maven
    $ mvn package
    ```
2. Export organization token
     ```bash
     export ROOKOUT_TOKEN=<Your-Token>
     ```
3. Run:
    ```bash
    $ java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar
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
    
2. Downloading the Rookout Java Agent from available on [maven central]:
    ```bash
    <dependencies>
        <dependency>
          <groupId>com.rookout</groupId>
          <artifactId>rook</artifactId>
          <version>0.1.36</version>
        </dependency>
    </dependencies>
    ```
    
3. Specifying the Rookout Java Agent when running:
    ```bash
        java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar 
    ```

[Java + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
