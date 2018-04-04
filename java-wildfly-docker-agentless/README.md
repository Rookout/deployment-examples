# Quickstart for Java + Wildfly + Agentless Rookout with Docker

A sample application for using Agentless Rookout + Java + Wildfly with Docker .

Before following this guide we recommend reading the basic [Java + Rookout] guide

## Rookout Integration Explained

There are 3 simple steps to integrate Rookout into your existing Java Wildfly web application:

1. Add the source files to your built .jar

1. Add our Wildfly standalone config script [available here](https://github.com/Rookout/deployment-examples/tree/master/java-wildfly-docker-agentless/rookout-conf)

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__

1. Set the Rook's agent configuration as environment variables in the Docker container


## Running locally
**Requirements:** `maven`, `docker`

1. Build the web application: in the `helloworld` directory run `mvn package`

1. Run `docker build --tag wildfly-helloworld . && docker run -it -p 8080:8080 -e "ROOKOUT_AGENT_HOST=cloud.agent.rookout.com" -e "ROOKOUT_AGENT_PORT=443" -e "ROOKOUT_TOKEN=<TOKEN>" wildfly-helloworld`

1. Open [http://localhost:8080/wildfly-helloworld](http://localhost:8080/wildfly-helloworld) to make sure everything works

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Rookout Integration Process
We have added Rookout to the original project by:
1. Adding sources to the project jar when building:
    ```xml
      <build>
        <plugins>
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-war-plugin</artifactId>
            <configuration>
              <webResources>
                <resource>
                  <directory>${build.sourceDirectory}</directory>
                  <targetPath>src</targetPath>
                </resource>
              </webResources>
            </configuration>
          </plugin>
        </plugins>
      </build>
    ```

1. Adding Rookout's Wildfly standalone config to add the javaagent to communicate with the app:
    ```bash
    # Fix wildfly logger issue because the rook java agent uses java.util.logging
    JBOSS_MODULES_SYSTEM_PKGS="org.jboss.logmanager"
    JBOSS_LOGMANAGER_VERSION="1.5.2.Final"
    JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.manager=org.jboss.logmanager.LogManager -Xbootclasspath/p:$JBOSS_HOME/modules/system/layers/base/org/jboss/logmanager/main/jboss-logmanager-$JBOSS_LOGMANAGER_VERSION.jar"
    # Set the rook as java agent
    JAVA_OPTS="$JAVA_OPTS -javaagent:/opt/jboss/wildfly/lib/rook.jar"
    ```
    
1. Set Docker container ENV for `ROOKOUT_AGENT_HOST` (default LOCALHOST), `ROOKOUT_AGENT_PORT` (default 7486) and `ROOKOUT_TOKEN` in order to connect to a remote hosted agent
    

[Java + Rookout]: https://rookout.github.io/tutorials/java
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
