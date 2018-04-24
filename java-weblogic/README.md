# Quickstart for Java + Rookout and Oracle WebLogic

Before following this guide we recommend reading the basic [Java + Rookout] guide

* [Running locally](#running-locally)
* [Using docker compose](#using-docker-compose)
* [Rookout Integration explained](#rookout-integration-explained)
* [Known Issues](#known-issues)

## Running locally
1. Run the Rookout agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
1. Add the Rookout javaagent as described in [Rookout Integration Explained](#rookout-integration-explained)
1. Build the sample helloworld WebLogic application:
    ``` bash
    $ cd weblogic-helloworld
    $ ant
    ```
    The built web application is now situated in `build/weblogic-helloworld.war`
1. Start your WebLogic domain `sh WEBLOGIC_HOME/user_projects/domains/DOMAIN_NAME/bin/startWebLogic.sh`
1. Deploy to WebLogic using the console (default url [http://localhost:7001/console](http://localhost:7001/console))
1. Go to [app.rookout.com](https://app.rookout.com/) and start debugging !

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout to the original project by:
1. Adding source files to the project .war in the ant task:
    ```xml
       <fileset dir="." includes="${source-directory}/**" />
    ```
1. Download javaagent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
1. Specified the javaagent in Weblogic startup script:
    
   - File location: `WEBLOGIC_HOME/user_projects/domains/DOMAIN_NAME/bin/startWebLogic.sh`
   
   - Find the line `JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} "`
   - Append the rook :
   ```bash
        JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} -javaagent=ROOK_LOCATION/rook.jar"
   ```

## Known Issues

- Rules will be showing a warning (orange) : Source file not found. This is caused by the way WebLogic runs web applications, the rook is still working properly but will not be able to know if the file used is matching the live one.

[Java + Rookout]: https://docs.rookout.com/docs/installation-java.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
