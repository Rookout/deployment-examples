# Rookout + Azure Functions

## Quickstart

1. Set up the Azure Functions CLI

2. Deploy the code:

```sh
mvn clean package azure-functions:deploy
```

3. Set Rookout token either via the Azure Portal or the CLI:

```sh
az functionapp config appsettings set --name jvmazure-20200323170137626 --settings  "ROOKOUT_TOKEN=<token>" --resource-group java-functions-group
```

4. Run the function

## Description

### Rookout SDK setup

The SDK is installed with a Maven dependency:

```xml
<dependency>
    <groupId>com.rookout</groupId>
    <artifactId>rook</artifactId>
    <version>LATEST</version>
</dependency>
```

The Rookout SDK is started in the function code using `API.start()`. You can call this function more than once, the SDK will only start one time.

We also package the source files in the JAR, to handle changes
in sources:

```xml
<resources>
    <resource>
        <directory>${project.basedir}/src/main/java<directory>
    </resource>
</resources>
```
Configuration can be set via environment variables or the RookOptions struct. See https://docs.rookout.com/docs/jvm-setup/.