# Quickstart for Python + Agentless Rookout on AWS Lambda

A sample application for using Python + Agentless Rookout on AWS Lambda
<details>
<summary>What is Agentless?</summary>
<p>
Instead of having to install your own Agent own the machine you are running the code from,
you can use one of our hosted Agents and just tell the Rook to connect to it.<br/>
For more information you can see <a href="https://docs.rookout.com/docs/installation-agent-remote.html">our documentation</a>
</p>
</details>


Before following this guide we recommend reading the basic [Python + Rookout] guide


## Rookout Integration Explained

There are 3 simple steps to integrate Rookout into your existing Python Lambda application for an agentless setup:

1. Add the pip dependency `rook` in the project folder

1. Wrap your lambda_handler function in our Rookout wrapper

1. Set the Rook's agent configuration as environment variables in the Lambda configuration


## Running on Lambda
1. Make sure your python module is called `lambda_function.py`

1. Uploading your function : 
    - Zip Upload: In order to run your rookout wrapped function on Lambda, make sure the dependencies are downloaded and zip
    the folder (including node_modules).  
    zip -r rookout_lambda_test.zip .

    **IMPORTANT:** _If you are building on a MacOS/Windows machine, pip will compile native binaries for this platform. AWS Lambda runs on Linux and thus needs the linux compiled binaries. The solution is doing `pip install <MODULE> -t .` on a Linux machine such as an EC2 instance and re-archive the zip for uploading to Lambda._

    - aws-cli : Create a new Lambda function and update it like so :
        ```bash
        $ aws lambda create-function --function-name rookout-lambda-test --runtime python2.7 --handler lambda_function.lambda_handler --role <IAM-ARN>
        $ aws lambda update-function-code --function-name rookout-lambda-test --zip-file fileb://rookout_lambda_test.zip --region {REGION}
        ```  
        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions)**

    - **OR** Using Cloud9 IDE integrated tools

    

1. Create a lambda function on AWS, you can follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)

1. Set the Rook's agent configuration as environment variables in the Lambda configuration

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !


## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing rookout dependency : `pip install rook -t .` (installs module in root folder)

1. Wrap your function by using our Rookout lambda wrapper like so :
    ```python
    def _lambda_handler(event, context):
        return 'Hello World'
    
    from rook import lambda_wrapper
    lambda_handler = lambda_wrapper.wrapper(_lambda_handler)
    ```
    
1. Set Lambda environment for `ROOKOUT_AGENT_HOST` (cloud.agent.rookout.com), `ROOKOUT_AGENT_PORT` (443) and `ROOKOUT_TOKEN` in order to connect to a remote hosted agent
    

[Python + Rookout]: https://rookout.github.io/tutorials/python