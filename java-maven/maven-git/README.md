# Quickstart for Java + Maven 

A sample application for using Rookout to debug a Java app built using Maven and git integration.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)

## Running locally
1. Clone and compile the project jar and download the Rookout Java Agent:
     ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/java-maven/maven-git
    mvn package
    ```
    Note: If your build fails with the message: `[ERROR] Source option 5 is no longer supported. Use 7 or later.`  You may need to add the maven.compiler properties to your pom.xml after the `<name>` field as follows:

    ```xml
    <properties>
        <maven.compiler.source>1.7</maven.compiler.source>
        <maven.compiler.target>1.7</maven.compiler.target>
    </properties>
    ```
2. Update the pom.xml with your Git remote origin path:
    ```xml
    <remoteOrigin>https://github.com/Rookout/deployment-examples.git</remoteOrigin>
    ```
4. Downloading the Rookout Java Agent from available on [maven central]::
    ```bash
    $ wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```  
5. Simply add the Rookout SDK as a Java Agent to your environment:
    ```bash
    # Add the Rookout Java Agent to your application using an environment variable
    $ export JAVA_TOOL_OPTIONS="-javaagent:(pwd)/rook.jar -DROOKOUT_TOKEN=[Your Rookout Token] -DROOKOUT_LABELS=env:dev"
    # Run the jar 
    $ java  -jar target/rookoutDemo-1.0.0-jar-with-dependencies.jar
    ```
6.  Run the Jar:
    ```bash    
    $ java  -jar target/rookoutDemo-1.0.0-jar-with-dependencies.jar
    ```

7. Make sure everything worked: [http://localhost:7000/](http://localhost:7000/hello)

8. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

1. We added the source to the project jar(`pom.xml`) for better source synchronization when debugging. This step is optional, as the Git integration will handle the source synchronization and make sure that you use the correct source versions.
    ```xml
    <resources>
        <resource>
            <directory>${basedir}/src/main/java</directory>
        </resource>
    </resources>
 
   ```
2. In order for Rookout's agent to sync with the right source code version, in this project we udpate the JAR's MANIFEST with commit hash and remote origin:
    ```xml
    <ROOKOUT_COMMIT>${buildNumber}</ROOKOUT_COMMIT>    
    <ROOKOUT_REMOTE_ORIGIN>${remoteOrigin}</ROOKOUT_REMOTE_ORIGIN>      
    ```
3. All of the MANIFEST update is accomplished using several plugins. We have added the following to the application's original pom.xml:
    Required properties:    
    ```xml
    <properties>
        <!-- Your remote origin path -->
        <remoteOrigin>https://github.com/Rookout/deployment-examples</remoteOrigin>
    </properties>
    ```
    Source control connection string:
    ```xml
   <!-- Setting the SCM plugin that we're using git -->
    <scm>
        <connection>scm:git:</connection>
    </scm>
    ```
    Adding the following plugins into your plugins tag:
    ```xml
    <!-- setup the buildnumber plugin -->
    <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>buildnumber-maven-plugin</artifactId>
        <version>1.4</version>       
        <executions>
            <execution>
                <phase>validate</phase>
                <goals>
                    <goal>create</goal>
                </goals>
            </execution>
        </executions>
        <configuration>
            <!-- 'doCheck' can be set to 'true' to first check and see if you have locally modified files, and will fail if there are any. -->
            <doCheck>false</doCheck>
            <doUpdate>false</doUpdate>
        </configuration>
    </plugin>

    <!-- scm plugin configuration -->
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-scm-plugin</artifactId>       
        <configuration>
            <!-- we'll be using the 'connection' configuration -->
            <connectionType>connection</connectionType>
        </configuration>
    </plugin>

    <!-- Use Jar plugin to add Rookout's git commit hash and remote origin -->
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-jar-plugin</artifactId>
        <version>2.1</version>
        <configuration>
            <archive>
                <manifest>
                    <addDefaultImplementationEntries>true</addDefaultImplementationEntries>
                </manifest>
                <manifestEntries>                            
                    <ROOKOUT_COMMIT>${buildNumber}</ROOKOUT_COMMIT>    
                    <ROOKOUT_REMOTE_ORIGIN>${remoteOrigin}</ROOKOUT_REMOTE_ORIGIN>                                                        
                </manifestEntries>
            </archive>
        </configuration>
    </plugin>
    ```

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
