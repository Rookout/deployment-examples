# Quickstart for Java + Gradle

A sample application for using Rookout SDK loaded using a simple API, to debug a Java app built using Gradle. 

Before following this guide we recommend reading the basic [Java + Rookout] guide

* [Running locally](#Running-local-application)
* [Rookout Integration explained](#rookout-integration-explained)

## Running local application
1. Clone and compile the project jar and download the Rookout Java Agent:
     ```bash
    $ git clone https://github.com/Rookout/deployment-examples/tree/master/java-gradle
    ```
2. Add your otganization token to line 14 at HelloWorld.java

3. Run using gradle:
    ```bash
    $ ./gradlew jar run
    ```
4. Make sure everything worked: [http://localhost:7000/](http://localhost:7000/)

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout API to the original project by:
1. Adding sources and dependencies to the project jar (`build.gradle`):
    ```properties
    // grab resources
    jar {
        from sourceSets.main.allSource
    }
    
    // declaring dependencies to the Rookout Java Agent
    configurations{
        rookoutAgent
    }
    
    // Running the Rookout Java Agent
    dependencies {
        compile group: 'com.rookout', name: 'rook', version: '0.1.51'
    }
    ```
2. Importing rookout API
    ```java
       import com.rookout.rook.API;
       import com.rookout.rook.RookOptions;
    ```
    
3. Start running the api
    ```java
       RookOptions opts = new RookOptions();
       opts.token = "<Your-Token>";
       API.start(opts);
    ```
[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
