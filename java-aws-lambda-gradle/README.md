# Deployment Example - Java + AWS Lambda + Gradle

## Structure

* `build/` - output folder (generated at build)
    * `classes/` - output .class files
    * `distributions/` - output .zip file
    * `libs/` - output .jar file
    * `tmp/` - temporary folder
* `gradle/` - gradle files
* `src/` - source files
    * `main/java/example/Handler.java` - function logic
* `build.gradle` - gradle build settings
* `settings.gradle` - gradle project settings

## Build, Upload, Configure

Steps using the AWS web UI:

1. Run `gradle build` in the project's root directory
1. Create a Lambda function or open an existing one in the AWS console
1. Go to the "Code" tab
1. Make sure the Lambda's runtime is "Java 11"
1. Click on "Upload from"
1. Select ".zip or .jar file"
1. Choose `buid/distributions/java-aws-lambda-gradle.zip`
1. Go to the "Configuration" tab
1. Click on "Environment variables"
1. Add the following variables:
    1. `JAVA_TOOL_OPTIONS=-Djdk.attach.allowAttachSelf=true`
    1. `ROOKOUT_TOKEN=[Your Rookout Token]`

Now run the function and start debugging.
