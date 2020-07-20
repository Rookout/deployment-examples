# Quickstart for Java + Maven 

A sample application for using Rookout to debug a Java app built using Maven.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)

## Running locally
1. Clone and compile the project jar and download the Rookout Java Agent:
     ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/java-maven/maven-agent
    mvn package
    ```
    Note: If your build fails with the message: `[ERROR] Source option 5 is no longer supported. Use 7 or later.`  You may need to add the maven.compiler properties to your pom.xml after the `<name>` field as follows:

    ```xml
    <properties>
        <maven.compiler.source>1.7</maven.compiler.source>
        <maven.compiler.target>1.7</maven.compiler.target>
    </properties>
    ```
2. Update the pom.xml with your Perforce depot path:
    ```xml
    <depotPath>//depot/path/to/project</depotPath>
    ```
3. Update the pom.xml with your Perforce connection string (see P4PORT):
    ```xml
    <scm>
        <connection>scm:p4:[protocol:][[username[:password]@]hostname:port:]${depotPath}</connection>
    </scm>
    ```
    For example:
     ```xml
    <scm>
        <connection>scm:p4:rookout.com:1666://depot/rookout/maven-example</connection>
    </scm>
    ```
4. Downloading the Rookout Java Agent from available on [maven central]::
    ```bash
    $ wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```  
5. Simply add the Rookout SDK as a Java Agent to your environment:
    ```bash
    # Add the Rookout Java Agent to your application using an environment variable
    $ export JAVA_TOOL_OPTIONS="-javaagent:$(pwd)/rook.jar -DROOKOUT_TOKEN=[Your Rookout Token]"
    # Optional labels
    $ export ROOKOUT_LABELS=env:dev
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

1. We added the source to the project jar(`pom.xml`) for better source synchronization when debugging. This step is optional, as the Perforce integration will handle the source synchronization and make sure that you use the correct source versions.
    ```xml
    <resources>
        <resource>
            <directory>${basedir}/src/main/java</directory>
        </resource>
    </resources>
 
   ```
2. In order for Rookout's agent to sync with the right source code version, in this project we udpate the JAR's MANIFEST with the depot path and changelist.
    Adding 2 attributes to the MANIFEST - Rookout-Revision and Rookout-Repository
3. All of the MANIFEST update is accomplished using several plugins. We have added the following to the application's original pom.xml:
    Required properties:    
    ```xml
     <properties>
        <!-- p4maven version, for easy version upgrade -->
        <p4maven.version>1.0.6</p4maven.version>
        <!-- Your Perforce depot path -->
        <depotPath>//depot/path/to/project</depotPath>
    </properties>
    ```
    Source control connection string:
    ```xml
      <!-- Set your Perforce connection string -->
    <scm>
        <connection>scm:p4:[protocol:][[username[:password]@]hostname:port:]${depotPath}</connection>
    </scm>
    ```
    Adding the following plugins into your plugins tag:
    ```xml
    <!-- setup the buildnumber plugin -->
    <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>buildnumber-maven-plugin</artifactId>
        <version>1.4</version>

        <dependencies>
            <dependency>
                <groupId>com.perforce.p4maven</groupId>
                <artifactId>p4maven-provider</artifactId>
                <version>${p4maven.version}</version>
            </dependency>
        </dependencies>
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
        <dependencies>
            <dependency>
                <groupId>com.perforce.p4maven</groupId>
                <artifactId>p4maven-provider</artifactId>
                <version>${p4maven.version}</version>
            </dependency>
        </dependencies>
        <configuration>
            <!-- we'll be using the 'connection' configuration -->
            <connectionType>connection</connectionType>
        </configuration>
    </plugin>

    <!-- Use the exec plugin to add Rookout's Perforce changelist and depot path. -->
    <!-- Using the exec plugin allows this integration to be simple and edit an already existing JAR -->
    <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>1.6.0</version>
        <executions>
            <execution>
            <!-- create a temporary manifest -->
                <id>create-temp-manifest</id>
                <!-- bind to the packaging phase -->
                <phase>package</phase>
                <goals>
                    <goal>exec</goal>
                </goals>
                <configuration>
                    <!-- write the Perforce parameters to a temp manifest file -->
                    <executable>printf</executable>
                    <workingDirectory>./</workingDirectory>
                    <arguments>
                        <argument>Rookout-Revision: ${buildNumber}\nRookout-Repository: Perforce:${depotPath}\n</argument>
                    </arguments>
                    <outputFile>manifest.tmp</outputFile>
                </configuration>
            </execution>
            <execution>
                <!-- update the existing JAR's manifest -->
                <id>update-jar</id>
                <!-- bind to the packaging phase -->
                <phase>package</phase>
                <goals>
                    <goal>exec</goal>
                </goals>
                <configuration>
                    <executable>jar</executable>
                    <!-- optional -->
                    <workingDirectory>./</workingDirectory>
                    <arguments>
                        <argument>uvfm</argument>
                        <argument>./target/${project.build.finalName}-jar-with-dependencies.jar</argument>
                        <argument>./manifest.tmp</argument>
                    </arguments>
                    <!-- write out to a log file, in case there are any errors -->
                    <outputFile>mf_update.log</outputFile>
                </configuration>
            </execution>
        </executions>
    </plugin>
    ```
4. Note that if you are running your Jar as a module on a different Jar (your Jar isn't the executable Jar). 
   Then you will have to direct Rookout to your Jar's path by setting the ROOKOUT_JAR_PATH environment variable.
    For Example:
    ```bash    
    $ export ROOKOUT_JAR_PATH=./target/rookoutDemo-1.0.0-jar-with-dependencies.jar
    ```
5. Note that in this example, we are updating the JAR by using Maven's properties and the predicted file name.
   If you are copying this method of updating your JAR to a different project, you'll have to update the JAR's name accordingly.
   This is the relvant line in the pom.xml for changing your JAR's name:
    ```xml    
    <argument>./target/${project.build.finalName}-jar-with-dependencies.jar</argument>
    ```
For more info on integrating Perforce with Maven - see [P4MAVEN](https://swarm.workshop.perforce.com/files/guest/dantran/p4maven/README.md)

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
