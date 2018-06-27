# Quickstart for Java + Agentless Rookout on AWS Lambda

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

There are XXXX simple steps to integrate Rookout into your existing Java application for an [agentless] setup:

1. Add gradle dependencies 
	```
	compile group: 'com.sun', name: 'tools', version: '1.7.0.13'
	compile group: 'com.rookout', name: 'rook', version: '0.1.12'
	```
	
	IMPORTANT:: the com.sun.tools is from nuiton repository. ("http://maven.nuiton.org/release/")

1. Call in your main function to LoadRook (add import com.rookout.rook.LoadRook;)
	```
	LoadRook.LoadRook();
	```

1. Set the Rook's agent configuration as environment variables in the Lambda configuration


## Running on Lambda

1. Uploading your function : 
    - Zip Content: In the root, create sub-folder named "lib" with the jars (tools.jar and rook.jar)

	You can simply add in your gradle file:
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
