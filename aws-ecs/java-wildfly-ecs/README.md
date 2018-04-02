# Quickstart for Java + Wildfly + Rookout and AWS Elastic Container Service

A sample application for using Rookout + Java + Wildfly + AWS Elastic Container Service .

Before following this guide we recommend reading the basic [Java + Rookout] guide

## Rookout Integration Explained

There are 2 simple steps to integrate Rookout into your existing java beanstalk application:

1. Add the source files to your built .jar

2. Add our Wildfly standalone config script [available here](https://github.com/Rookout/deployment-examples/tree/master/aws-ecs/java-wildfly-ecs/rookout-conf)

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__


## Running locally
**The docker-compose file takes care of running a Rookout Agent container**

1. Set your agent token in the `docker-compose.yml` file

1. Build the web application: in the `helloworld` directory run `svn package`

1. Run `docker-compose up`

1. Go to [http://localhost/wildfly-helloworld](http://localhost/wildfly-helloworld) to make sure everything works

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Running on AWS Elastic Container Service
**The docker-compose file takes care of running a Rookout Agent container**

1. Set your agent token in the `docker-compose.yml` file

1. Build the web application: in the `helloworld` directory run `svn package`

1. Build custom wildfly image by running `docker build --tag=wildfly-helloworld .`

1. Upload your docker image to a registry

1. Change the `docker-compose.yml` to use your image as a build

1. Create an ECS service from the docker-compose file using ecs-cli : `ecs-cli compose service --project-name wildfly-rookout create`

1. Run the task from the AWS console

1. Make sure everything worked by accessing the url of your cluster after build completed with at route `http://$URL/wildfly-helloworld`

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
    

[Java + Rookout]: https://rookout.github.io/tutorials/java
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook