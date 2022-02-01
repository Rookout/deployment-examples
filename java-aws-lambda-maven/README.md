# Deployment Example - Java + AWS Lambda + Maven

This is an example of an AWS Lambda with Rookout integrated into it. Deploy this example to test things out, or follow [our docs](https://docs.rookout.com/docs/jvm-setup/#serverless-and-paas-deployments) to learn how to integrate Rookout into your own application.

This example is written for Java 11, but Rookout also supports Java 8 on AWS Lambda.

## Structure

* `target/` - output folder (generated at build)
    * `classes/` - output .class files
    * `java-aws-lambda-maven-1.0-SNAPSHOT.jar` - output .jar file
    * `original-java-aws-lambda-maven-1.0-SNAPSHOT.jar` - temporary file
* `src/` - source files
    * `main/java/example/Handler.java` - function logic
* `pom.xml` - maven settings

## Build, Upload, Configure

Steps using the AWS web UI:

1. Run `mvn package` in the project's root directory
1. Create a Lambda function or open an existing one in the AWS console
1. Go to the "Code" tab
1. Make sure the Lambda's runtime is "Java 11"
1. Click on "Upload from"
1. Select ".zip or .jar file"
1. Choose `target/java-aws-lambda-maven-1.0-SNAPSHOT.jar`
1. Go to the "Configuration" tab
1. Click on "Environment variables"
1. Add the following variables:
    1. `JAVA_TOOL_OPTIONS=-Djdk.attach.allowAttachSelf=true`
    1. `ROOKOUT_TOKEN=[Your Rookout Token]`

Now run the function and start debugging.
