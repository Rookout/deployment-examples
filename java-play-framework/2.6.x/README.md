[<img src="https://img.shields.io/travis/playframework/play-java-starter-example.svg"/>](https://travis-ci.org/playframework/play-java-starter-example)

# Rookout and play-java-starter-example

This is a starter application that shows how Play works with Rookout.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Run the Rookout ETL Agent 

1. Run the Rookout ETL Agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
## Running with sbt dist

1.  Run the following commands:
    ``` bash
    $ cd 2.6.x
    $ make build
    ```
    - For Unix run:
    ``` bash
    $ make run
    ```

## Rookout Integration explained
This example make sure to set up Rookout`s SDK as a Java Agent for Play Framework
  1. Add the Rookout Java Agent plugin
    ```
    addSbtPlugin("com.lightbend.sbt" % "sbt-javaagent" % "0.1.4")
    ```
  1. Enable the Rookout Java Agent
    ```
    lazy val root = (project in file(".")).enablePlugins(PlayJava, JavaAgent)
    ```
  1. Add the Rookout Java Agent to your configuration
    ```
    javaAgents += "com.rookout" % "rook" % "0.1.9" % "dist"
    ```


## Running with sbt run
Create lib folder and download The Rookout SDK (aka "Rook")
 
``` bash
    $ make run dev
```

## Debug Playframework

1. And then go to http://localhost:9000 to see the running web application.

1. Go to [app.rookout.com](https://app.rookout.com/) and start debugging !
