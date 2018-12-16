# Quickstart for debugging Java + Oracle WebLogic 

A sample application for debugging Java + Oracle WebLogic using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

* [Running locally](#running-locally)
* [Using docker compose](#using-docker-compose)
* [Rookout Integration explained](#rookout-integration-explained)
* [Known Issues](#known-issues)

## Running locally
1. Run the Rookout ETL Agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
1. Add the Rookout Java Agent as described in [Rookout Integration Explained](#rookout-integration-explained).
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
1. Downloading the Rookout Java Agent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
1. Specified the Rookout Java Agent in Weblogic startup script:
    
   - File location: `WEBLOGIC_HOME/user_projects/domains/DOMAIN_NAME/bin/startWebLogic.sh`
   
   - Find the line `JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} "`
   - Append the Rookout SDK (aka "Rook") :
   ```bash
        JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} -javaagent=ROOK_LOCATION/rook.jar"
   ```

## Known Issues

- Breakpoints will be showing a Warning: Source file not found. This is caused by the way WebLogic runs web applications, the rook is still working properly but will not be able to know if the file used is matching the live one.

[Java + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
