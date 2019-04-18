# Quickstart for Java + Maven 

A sample application for using Rookout API to debug a Java app built using Maven.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)

## Running locally
1. Clone and compile the project jar and download the Rookout Java Agent:
     ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/java-maven/maven-api
    mvn package
    ```
2. Run:
    ```bash
    java -jar target/rookoutDemo-1.0.0-jar-with-dependencies.jar
    ```

3. Make sure everything worked: [http://localhost:7000/](http://localhost:7000/hello)

4. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

1. We imported Rookout API to the project jar(`pom.xml`) to enable rookout:
    ```xml
            <dependency>
               <groupId>com.rookout</groupId>
               <artifactId>rook</artifactId>
               <version>0.1.51</version>
           </dependency>
    ```
2. Importing rookout API
    ```java
       import com.rookout.rook.API;
       import com.rookout.rook.RookOptions;
    ```
    
3. Start running the API
    ```java
       RookOptions opts = new RookOptions();
       opts.token = "<Your-Token>";
       API.start(opts);
    ```

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
