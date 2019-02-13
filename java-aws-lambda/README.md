# Quickstart for debugging a Java application deployed in AWS Lambda using Rookout

A sample application for debugging Java + AWS Lambda using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Integrate Rookout into your Java application

To integrate Rookout into your existing Java application, follow these steps:

1. Add gradle dependencies:
	```
	compile group: 'com.sun', name: 'tools', version: '1.7.0.13'
	compile group: 'com.rookout', name: 'rook', version: '0.1.12'
	```
	
	NOTE: the com.sun.tools repository is taken from the nuiton repository - (http://maven.nuiton.org/release/).

1. Call LoadRook() in your main() function to load the Rookout SDK. Make sure to import com.rookout.rook.API.
	```
	API.Load();
	```

1. Set your Rookout token ('ROOKOUT_TOKEN') as an environment variable in the Lambda configuration.

## Run your application

1. Upload your function: 
    - As a Zip package: Create a sub-folder named "lib" with the required .jar files (tools.jar and rook.jar) in the root folder.

	You can also add the files in your gradle file:
	```
	task buildZip(type: Zip) {
		from compileJava
		from processResources
		into('lib') {
			from configurations.runtime
		}
	}	
	
	build.dependsOn buildZip
	```
	
    - Using AWS CLI: Create a new Lambda function and update it as follows:
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
                    --environment Variables="{ROOKOUT_TOKEN=<org_token>,ROOKOUT_ROOK_TAGS=lambda}"
      ```
        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

    - Using Cloud9 IDE integrated tools.

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
