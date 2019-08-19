# Quickstart Debugging Java Sbt scala using Rookout

A sample application for debugging Java Sbt scala using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide

## Integrate Rookout into your Java application

To integrate Rookout into your existing Java application, follow these steps:

1. [Download the Rookout Java Agent](http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST)
2. Add Rookout as a javaagent to your environment variable as following:
```bash
JAVA_OPTS=-javaagent:<PATH-TO-ROOK.JAR>
```
3. Set your Rookout Token as the `ROOKOUT_TOKEN` environment variable, or append the server.ini (after the javaagent):
```bash
-DROOKOUT_TOKEN=<YOUR-TOKEN>
```
4. Add your sources to your jar by adding the following line to your main `build.sbt` file:
```bash
resourceDirectory in Compile := sourceDirectory.value
```
5. Pack your app, run it and start debugging!  

Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
