[<img src="https://img.shields.io/travis/playframework/play-java-starter-example.svg"/>](https://travis-ci.org/playframework/play-java-starter-example)

# rookout and play-java-starter-example

This is a starter application that shows how Play works with Rookout.

## Run Rookout Agent 

1. Run the Rookout agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
## Running with sbt dist

1.  Run the following commands:
    ``` bash
    $ sbt dist
    $ cd target/universal
    $ unzip play-java-starter-example-1.0-SNAPSHOT.zip 
    $ cd play-java-starter-example-1.0-SNAPSHOT/bin
    ```

    - For Windows run:
    ``` bash
    $ play-java-starter-example -Dplay.file=../conf/application.conf
    ```

    - For Unix users
    ``` bash
    $ chmod +x play-java-starter-example
    $ play-java-starter-example -Dplay.file=../conf/application.conf
    ```

## Rookout Integration explained
This example make sure to set up Rookout`s SDK as Java Agent for Play Framework
  1. Add Java Agent plugin
    ```
    addSbtPlugin("com.lightbend.sbt" % "sbt-javaagent" % "0.1.4")
    ```
  1. Enable Java Agent
    ```
    lazy val root = (project in file(".")).enablePlugins(PlayJava, JavaAgent)
    ```
  1. Set rook as the Java Agent
    ```
    javaAgents += "com.rookout" % "rook" % "0.1.9" % "dist"
    ```

## Running with sbt run
Create lib folder and download Rookout`s rook module
 
``` bash
$ mkdir lib ; cd lib ; wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
```

```
sbt run
```

## Debug Playframework

1. And then go to http://localhost:9000 to see the running web application.

1. Go to [app.rookout.com](https://app.rookout.com/) and start debugging !
