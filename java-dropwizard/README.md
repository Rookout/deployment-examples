[<img src="https://img.shields.io/travis/playframework/play-java-starter-example.svg"/>](https://travis-ci.org/playframework/play-java-starter-example)

# Debug a DropWizard app using Rookout

A sample app for debugging DropWizard using Rookout.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Overview

Included with this application is an example of the optional DB API module. The examples provided illustrate a few of
the features available in [Hibernate](http://hibernate.org/), along with demonstrating how these are used from within
Dropwizard.

This database example is comprised of the following classes:

* The `PersonDAO` illustrates using the Data Access Object pattern with assisting of Hibernate.

* The `Person` illustrates mapping of Java classes to database tables with assisting of JPA annotations.

* All the JPQL statements for use in the `PersonDAO` are located in the `Person` class.

* `migrations.xml` illustrates the usage of `dropwizard-migrations` which can create your database prior to running
your application for the first time.

* The `PersonResource` and `PeopleResource` are the REST resource which use the PersonDAO to retrieve data from the database, note the injection
of the PersonDAO in their constructors.

As with all the modules the db example is wired up in the `initialize` function of the `HelloWorldApplication`.

## Setting Up The Application

To test the example application run the following commands:

* To create the example, package the application using [Apache Maven](https://maven.apache.org/) from the root dropwizard directory, run:
```
        mvn package
```
* To setup the h2 database run:
```
        java -jar target/dropwizard-example-$DW_VERSION.jar db migrate example.yml
```

## Deploy and Run Rookout's Java Agent

1.  Download:

    ```
    $ curl -L "https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST" -o rook.jar
    ```

1. Run:

    ```
    java -javaagent:rook.jar -jar target/dropwizard-example-$DW_VERSION.jar server example.yml
    ```

## Debug with Rookout's IDE
1. Go to https://app.rookout.com and add your sources

1. Add a Breakpoint at src/main/java/com/example/helloworld/api/Saying.java : Line 17

1. To hit the Hello World example (hit refresh a few times).

    http://localhost:8080/hello-world

1. To post data into the application.

    curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
    

    open http://localhost:8080/people

# For more information
Visit our online documentation: https://docs.rookout.com/