# Quickstart Debugging Java Servlet WAR running on Tomcat using Rookout

A sample application for debugging Java Servlet WAR running on Tomcat using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide

## Integrate Rookout into your Java application

To integrate Rookout into your existing Java application, follow these steps:

1. [Download the Rookout Java Agent](http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST)
2. Add Rookout as a javaagent to the `CATALINA_OPTS` environment variable: `export CATALINA_OPTS="$CATALINA_OPTS -javaagent:$CATALINA_HOME/rook.jar"`
3. Set your Rookout Token as the `ROOKOUT_TOKEN` environment variable

## Run your application on an existing Tomcat server

1. Package your application as a WAR: `mvn package`
2. Deploy it to your Tomcat server: `cp sample.war /usr/local/tomcat/sample.war`
3. Browse to the app at /sample/

## Use Docker instead

- Build the Dockerfile in this repo and run it to start a Tomcat server complete with the sample WAR running:
1. `docker build -t rookout-deployment-example/java-tomcat-war .`
2. `docker run -e ROOKOUT_TOKEN=<your token> -p 8080:8080 --rm rookout-deployment-example/java-tomcat-war`
3. Browse to the app at http://localhost:8080/sample/


Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
