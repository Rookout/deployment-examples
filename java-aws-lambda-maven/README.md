# Quickstart for Java + Agentless Rookout on AWS Lambda Maven

A sample application for using Java + Agentless Rookout on AWS Lambda
<details>
<summary>What is Agentless?</summary>
<p>
Instead of having to install your own Agent own the machine you are running the code from,
you can use one of our hosted Agents and just tell the Rook to connect to it.<br/>
For more information you can see <a href="https://docs.rookout.com/docs/installation-agent-remote.html">our documentation</a>
</p>
</details>


Before following this guide we recommend reading the basic [Java + Rookout] guide


## Rookout Integration Explained

There are 4 simple steps to integrate Rookout into your existing Java application for an [agentless] setup:

1. Add maven dependencies to pom.xml file 
```
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
	
IMPORTANT:: the com.sun.tools is from nuiton repository. ("http://maven.nuiton.org/release/")

```
<repositories>
	<repository>
	<id>nuiton</id>
	<name>nuiton</name>
	<url>http://maven.nuiton.org/release/</url>
	</repository>
</repositories>
```

2. Creating an xml file as a Descriptor for maven assembly plugin \ Use a pre-defined descriptor

```
<assembly xmlns="http://maven.apache.org/ASSEMBLY/2.0.0"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://maven.apache.org/ASSEMBLY/2.0.0 http://maven.apache.org/xsd/assembly-2.0.0.xsd">
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

3. Call in your main function to LoadRook (add import com.rookout.rook.API;)
```
API.Load();
```

4. Set the Rook's agent configuration as environment variables in the Lambda configuration


## Running on Lambda	

1. Deploying your function : 
    - Zip Content: use mvn package command to package everthing within one java-aws-lambda-maven-1.0-SNAPSHOT-jar-with-dependencies.jar file

	```
	mvn package
	```
	
    - aws-cli : Create a new Lambda function and update it like so :
        ```bash
        aws lambda create-function \
                    --region <REGION> \
                    --function-name rookout_lambda_test \
                    --zip-file fileb://java_lambda_test.zip \
                    --role <ROLE-ARN> \
                    --handler TestLambda.TestLambda::handleRequest \
                    --runtime java8 \
					--timeout 25 
					--memory-size 400 
                    --environment Variables="{ROOKOUT_AGENT_HOST=cloud.agent.rookout.com,ROOKOUT_AGENT_PORT=443,ROOKOUT_ROOK_TAGS=lambda,ROOKOUT_TOKEN=<org_token>}"```

        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

    - **OR** Using Cloud9 IDE integrated tools

1. Set the Rook's agent configuration as environment variables in the Lambda configuration, fill the Environment Variables for :
    - `ROOKOUT_AGENT_HOST` : cloud.agent.rookout.com
    - `ROOKOUT_AGENT_PORT` : 443
    - `ROOKOUT_TOKEN` : Your Organization Token
    
    More information can be found in [our documentation](https://docs.rookout.com/docs/installation-agent-remote.html)

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/installation-java.html
