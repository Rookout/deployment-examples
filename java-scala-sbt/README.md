# Quickstart Debugging sbt app using Rookout

A sample application for debugging a Scala app using Rookout.

## Integrate Rookout into your sbt application

To integrate Rookout into your existing Scala application, follow these steps:

1. [Download the Rookout Java Agent](http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST)
2. Add Rookout as a javaagent to your environment variable as following:
```bash
JAVA_OPTS=-javaagent:<PATH-TO-ROOK.JAR>
```
3. Set your Rookout Token as the `ROOKOUT_TOKEN` environment variable. (Your token is available in your [Rookout App](app.rookout.com).

4. Add your sources to your jar by adding the following line to your main `build.sbt` file:

    (where `./src/main/scala` is the base directory of your Scala source files)
```bash
Compile / unmanagedResourceDirectories += baseDirectory.value / "./src/main/scala"
```
5. Pack your app, run it and start debugging!  

Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
