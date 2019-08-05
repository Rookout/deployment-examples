# Quickstart Debugging Java Servlet WAR running on Jetty using Rookout

A sample application for debugging Java Servlet WAR running on Jetty using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide

## Integrate Rookout into your Java application

To integrate Rookout into your existing Java application, follow these steps:

1. [Download the Rookout Java Agent](http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST)
2. Add Rookout as a javaagent to the `server.ini` (`start.ini` on windows) configuration file as the following:
```bash
--exec
-javaagent:<PATH-TO-ROOK.JAR>
```
3. Set your Rookout Token as the `ROOKOUT_TOKEN` environment variable, or append the server.ini (after the javaagent):
```bash
-DROOKOUT_TOKEN=<YOUT-TOKEN>
```

## Run your application on an existing Jetty server

1. Package your application as a WAR: `mvn package`
2. Deploy it to your Jetty server: `cp jetty-helloworld.war /var/lib/jetty/webapps/`
3. Browse to the app at /jetty-helloworld

## Use Docker instead

- Build the Dockerfile in this repo and run it to start a Jetty server complete with the sample WAR running:
1. `docker build -t rookout-deployment-example/java-jetty-war .`
2. `docker run -e ROOKOUT_TOKEN=<your token> -p 8080:8080 --rm rookout-deployment-example/java-jetty-war`
3. Browse to the app at http://localhost:8080/jetty-helloworld/


Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
