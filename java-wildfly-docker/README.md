# Quickstart for Java + Wildfly debugging

A sample application for debugging Java + Wildfly apps using Rookout and Docker.

Before following this guide we recommend completing the basic [Rookout Java deployment tutorial](https://github.com/Rookout/tutorial-java).

## Rookout Integration Explained

There are 3 simple steps to integrate Rookout into your existing Java Wildfly web application:

1. Add the source files to your built .jar

1. Add our Wildfly standalone config script [available here](https://github.com/Rookout/deployment-examples/tree/master/java-wildfly-docker/helloworld/rookout-conf).

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__

1. Set the Rookout Java ETL configuration as environment variables in the Docker container.


## Running locally
**Requirements:** `maven`, `docker`

1. Set your organization token in `rookout-conf/standalone.conf` on line 39

1. Build the web application: in the `helloworld` directory run `mvn package`

1. Run `docker build --tag wildfly-helloworld . && docker run -it -p 8080:8080 wildfly-helloworld`

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
    # Fix logger issue and class loading
    JBOSS_MODULES_SYSTEM_PKGS="org.jboss.logmanager,com.rookout"
    JBOSS_LOGMANAGER_VERSION="1.5.2.Final"
    JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.manager=org.jboss.logmanager.LogManager -Xbootclasspath/p:$JBOSS_HOME/modules/system/layers/base/org/jboss/logmanager/main/jboss-logmanager-$JBOSS_LOGMANAGER_VERSION.jar"
    # Set the Rookout Java Agent
    JAVA_OPTS="$JAVA_OPTS -javaagent:/opt/jboss/wildfly/lib/rook.jar"
    ```
    
    *Known issue: The confirguration overrides the log manager to use jboss.logmanager no matter what. This is because
    the Rookout Java Agent uses the default java logging and Wildfly is unable to start without its logger.*
    
1. Set these variables in the `standalone.conf` at the top of the file like so in order to connect to the right ETL Controller:
    ```bash
    export ROOKOUT_TOKEN="YOUR_TOKEN"
    ```
    

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
