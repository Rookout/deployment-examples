[<img src="https://img.shields.io/travis/playframework/play-java-starter-example.svg"/>](https://travis-ci.org/playframework/play-java-starter-example)

# Rookout and play-java-starter-example

This is a starter application that shows how Play works with Rookout.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Running with Rookout

1. Export Organization Token:
    ``` bash
    $ export ROOKOUT_TOKEN=<your-token>
    ```

2.  Run the following command:
    ``` bash
    $ make build prod
    ```

## Rookout Integration explained
This example makes sure to set up Rookout`s SDK as Java Agent for Play Framework
  1. Add Java Agent plugin
    ```
    addSbtPlugin("com.lightbend.sbt" % "sbt-javaagent" % "0.1.4")
    ```
  1. Enable the Rookout Java Agent
    ```
    lazy val root = (project in file(".")).enablePlugins(PlayJava, JavaAgent)
    ```
  1. Add the Rookout Java Agent to your configuration
    ```
    javaAgents += "com.rookout" % "rook" % "0.1.47" % "dist"
    ```
## Debug Playframework

1. And then go to http://localhost:9000 to see the running web application.

1. Go to [app.rookout.com](https://app.rookout.com/) and start debugging !
