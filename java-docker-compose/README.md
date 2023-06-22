# Quickstart for Java Docker Compose debugging

A sample application for using Rookout to debug a Java app built using Maven or Gradle, and deployed using Docker Compose.

Before following this guide we recommend completing the basic [Java + Rookout tutorial](https://github.com/Rookout/tutorial-java).

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

* [Using Docker Compose](#using-docker-compose)
* [Rookout Integration explained](#rookout-integration-explained)

## Using Docker Compose

1. Compile the project jar:
     ```bash
    $ make build-local-maven
    ```
    or
    ```bash
    $ make build-local-gradle
    ```
2. Edit docker-compose.yaml and add your Rookout token:
    ``` YAML
        environment:
          ROOKOUT_TOKEN: YOUR_TOKEN_HERE
    ```
3. Build the image:
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
    
2. Downloading the Rookout Java Agent available on [maven central]:
    ```bash
        wget "https://search.maven.org/remote_content?g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
    
3. Configuring our `ROOKOUT_TOKEN` on `docker-compose.yaml`:
    ``` YAML
        environment:
          ROOKOUT_TOKEN: YOUR_TOKEN_HERE
    ```    
    
3. Specifying the Rookout Java Agent when running:
    ```bash
        java  -javaagent:rook.jar -jar target/rookoutDemo-1.0.0.jar 
    ```


[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
