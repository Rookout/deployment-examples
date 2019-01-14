[<img src="https://img.shields.io/travis/playframework/play-java-starter-example.svg"/>](https://travis-ci.org/playframework/play-java-starter-example)

# Debug a DropWizard app using Rookout

A sample app for debugging DropWizard using Rookout.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Overview

The entire app is only two Java files and a pom.xml. The Java files are split into the application (with the main method) and the resource (i.e. the routes).

[source repository](https://github.com/pgr0ss/dropwizard-example)
## Setting Up The Application

To test the example application run the following commands:

* To create the example, package the application using [Apache Maven](https://maven.apache.org/) from the root dropwizard directory, run:
```
        mvn package
```

## Deploy and Run Rookout's Java Agent

1.  Download:

    ```
    $ curl -L "https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST" -o rook.jar
    ```

1. Run:

    ```
    java -javaagent:rook.jar -jar target/dropwizard-example-1.0-SNAPSHOT.jar server
    ```

## Debug with Rookout's IDE
1. Go to https://app.rookout.com and add your sources

1. Add a Breakpoint at src/main/java/Resource.java : Line 12

1. Trigger the Breakpoint by navigating to our HelloWorld route:

    http://localhost:8080/hello
    
# For more information
Visit our online documentation: https://docs.rookout.com/
