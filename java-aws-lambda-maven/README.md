# Quickstart Debugging Java based AWS Lambda + Maven applications using Rookout

A sample application for debugging Java + Maven + AWS Lambda using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Integrate Rookout into your Java application

To integrate Rookout into your existing Java application, follow these steps:

1. Add the following Maven dependencies to your pom.xml file:
``` xml
<dependencies>
	<dependency>
		<groupId>com.amazonaws</groupId>
		<artifactId>aws-lambda-java-core</artifactId>
		<version>1.1.0</version>
	</dependency>
	<dependency>
		<groupId>com.rookout</groupId>
		<artifactId>rook</artifactId>
		<version>[0.1.28,)</version>
	</dependency>
	<dependency>
		<groupId>com.sun</groupId>
		<artifactId>tools</artifactId>
		<version>1.7.0.13</version>
	</dependency>
</dependencies>
```
	
NOTE: the com.sun.tools repository is taken from the nuiton repository - (http://maven.nuiton.org/release/).

Make sure you reference the following repository:

``` xml
<repositories>
	<repository>
	<id>nuiton</id>
	<name>nuiton</name>
	<url>http://maven.nuiton.org/release/</url>
	</repository>
</repositories>
```

2. Create an xml file in the project's root directory as a Descriptor for maven assembly plugin, or use a pre-defined descriptor:

``` xml
<assembly xmlns="http://maven.apache.org/ASSEMBLY/2.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/ASSEMBLY/2.0.0 http://maven.apache.org/xsd/assembly-2.0.0.xsd">
	<id>jar-with-dependencies</id>
	<formats>
		<format>jar</format>
	</formats>
	<includeBaseDirectory>false</includeBaseDirectory>
	<dependencySets>
		<dependencySet>
		<outputDirectory>/lib</outputDirectory>
		<useProjectArtifact>true</useProjectArtifact>
		<unpack>false</unpack>
		<scope>runtime</scope>
		<unpackOptions>
			<excludes>
			<exclude>META-INF/**</exclude>
			</excludes>
		</unpackOptions>
		</dependencySet>
	</dependencySets>
</assembly>
```

3. Call LoadRook() from your main() function to load the Rookout SDK. Make sure to import com.rookout.rook.API.

``` java
import com.rookout.rook.API;

public class TestLambda implements RequestHandler<Object, String> {
    @Override
    public String handleRequest(Object myCount, Context context) {

		API.Load();
		
		// Your awesome code here :)
    }
```

4. Set your Rookout Token ('ROOKOUT_TOKEN') as an environment variable

## Run your application

1. Deploying your function : 
    - As a **Zip package**: use the mvn package command to package everthing within one java-aws-lambda-maven-1.0-SNAPSHOT-jar-with-dependencies.jar file.

	```
	mvn package
	```
	
    - Using **AWS CLI** : Create a new Lambda function and update it as follows:
        ```bash
        aws lambda create-function \
                    --region <REGION> \
                    --function-name rookout_lambda_test \
                    --zip-file fileb://java_lambda_test.zip \
                    --role <ROLE-ARN> \
                    --handler TestLambda.TestLambda::handleRequest \
                    --runtime java8 \
			    --timeout 25 \
			    --memory-size 400 \
                    --environment Variables="{ROOKOUT_TOKEN=<org_token>,ROOKOUT_ROOK_TAGS=lambda}" 
      ```
        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

    - Using **Cloud9 IDE** integrated tools.

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
