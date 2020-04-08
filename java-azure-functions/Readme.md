# Rookout + Azure Functions

## Quickstart

1. Set up the Azure Functions CLI

2. Deploy the code:

```sh
mvn clean package azure-functions:deploy
```

3. Set Rookout token either via the Azure Portal or the CLI:

```sh
az functionapp config appsettings set --name <your_function_name>  --settings  "JAVA_OPTS=-javaagent:./lib/rook.jar -DROOKOUT_TOKEN=<your_rookout_org_token>" --resource-group <your_resource_group>
```

4. Run the function and go to [app.rookout.com](https://app.rookout.com) and start debugging !

## Description

### Rookout SDK setup

1. The SDK is installed with a Maven dependency:

```xml
<dependency>
    <groupId>com.rookout</groupId>
    <artifactId>rook</artifactId>
    <version>LATEST</version>
</dependency>
```
2. In order to properly load the Rookout jar, you will also need to strip the version from the jar deployment.
This can be achieved with updating the stripVersion attribute in the Maven dependency plugin.

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-dependency-plugin</artifactId>
    <executions>
        <execution>
            <id>copy-dependencies</id>
            <phase>prepare-package</phase>
            <goals>
                <goal>copy-dependencies</goal>
            </goals>
            <configuration>
                <outputDirectory>${stagingDirectory}/lib</outputDirectory>
                <overWriteReleases>false</overWriteReleases>
                <overWriteSnapshots>false</overWriteSnapshots>
                <overWriteIfNewer>true</overWriteIfNewer>
                <includeScope>runtime</includeScope>
                <excludeArtifactIds>azure-functions-java-library</excludeArtifactIds>
                <!-- Rookout: strip the rook.jar version-->
                <stripVersion>true</stripVersion>
            </configuration>
        </execution>
    </executions>
</plugin>
```
3. We also package the source files in the JAR, to handle changes
in sources:

```xml
<resources>
    <resource>
        <directory>${project.basedir}/src/main/java<directory>
    </resource>
</resources>
```

4. If you are using a consumption plan you will also need to define the WEBSITE_USE_PLACEHOLDER app settings to be 0. This step isn't needed if you use a premium plan with Azure.
To set this app settings, you can either do it via the Azure portal or via cli:
```sh
az functionapp config appsettings set --name <your_function_name>  --settings  "WEBSITE_USE_PLACEHOLDER=0" --resource-group <your_resource_group>
```
You can read more about this in the Azure documentation [here](https://github.com/Azure/azure-functions-java-worker/wiki/How-to-set-JAVA_OPTS-to-customize-JVM-options-on-Azure-Functions) and [here](https://github.com/projectkudu/kudu/wiki/Configurable-settings)

5. If using stripVersion will interrupt with other dependency integrations then you can specify a version for the Rookout rook jar dependency and then specify it in the JAVA_OPTS.
(Note that Rookout supports Java Azure Functions from 0.1.109 forward)
Update the dependency:
```xml
<dependency>
    <groupId>com.rookout</groupId>
    <artifactId>rook</artifactId>
    <version>0.1.109</version>
</dependency>
```
And specify the version when setting the JAVA_OPTS:
```sh
az functionapp config appsettings set --name <your_function_name>  --settings  "JAVA_OPTS=-javaagent:./lib/rook-0.1.109.jar -DROOKOUT_TOKEN=<your_rookout_org_token>" --resource-group <your_resource_group>
```
This method isn't recommended is it will require updating both the pom.xml and the JAVA_OPTS when you upgrade the Rookout version, and this you won't be using our latest version.
