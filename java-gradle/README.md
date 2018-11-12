# Quickstart for Java + Gradle and Docker-compose

A sample application for using Rookout to debug a Java app built using Gradle, and deployed using Docker Compose.

Before following this guide we recommend reading the basic [Java + Rookout] guide

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

* [Running locally](#running-locally)
* [Using docker compose](#using-docker-compose)
* [Rookout Integration explained](#rookout-integration-explained)
## Running local application using Agent-less
1. Compile the project jar and download the Rookout Java Agent:
     ```bash
    $ make build
    ```
2. Run using your Rookout Token:
    ```bash
    $ make run token=YOUR_TOKEN
    ```
3. Run using gradle:
    ```bash
    $ make gradle-run token=YOUR_TOKEN
    ```
4. Make sure everything worked: [http://localhost:7000/](http://localhost:7000/)

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout to the original project by:
1. Adding soruces to the project jar(`build.gradle`):
    ```properties
    jar {
        from sourceSets.main.allSource
    }
    ```
2. Downloading the Rookout Java Agent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
3. Specifying the Rookout Java Agent when running:
    ```bash
        java  -javaagent:rook.jar -jar build/libs/rookoutDemo-1.0.0.jar
    ```

[Java + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
