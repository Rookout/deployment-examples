# Quickstart for Java + Maven 

A sample application for using Rookout to debug a Java app built using Maven.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)

## Running locally
1. Clone and compile the project jar and download the Rookout Java Agent:
     ```bash
    $ git clone https://github.com/Rookout/deployment-examples/tree/master/java-maven
    $ mvn package
    ```
2. Export your Rookout Token
     ```bash
     export ROOKOUT_TOKEN=<Your-Token>
     ```
3. Downloading the Rookout Java Agent from available on [maven central]::
    ```bash
    $ wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```  
4. Specifying the Rookout Java Agent when running:
    ```bash
    $ java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0-jar-with-dependencies.jar
    ```

4. Make sure everything worked: [http://localhost:7000/](http://localhost:7000/hello)

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

1. We added the source to the project jar(`pom.xml`) to enable rookout:
    ```xml
            <resources>
                <resource>
                    <directory>${basedir}/src/main/java</directory>
                </resource>
            </resources>
    ```
    

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
