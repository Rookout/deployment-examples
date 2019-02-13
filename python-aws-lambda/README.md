# Quickstart for debugging Python + AWS Lambda

A sample application for debugging Python apps deployed in AWS Lambda using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout] guide

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Rookout Integration Explained

To integrate the Rookout SDK (aka "rook") into your existing Python Lambda app, follow these steps:

1. Add the pip dependency `rook` in the project folder.

1. Wrap your lambda_handler function in our Rookout wrapper.

1. Set your Rookout Token as an environment variable in the Lambda configuration.

## Running on Lambda
1. Make sure your python module is called `lambda_function.py` to use our example.

1. Uploading your function : 
    - **Zip Upload**: In order to run your Rookout-wrapped function on Lambda, make sure the dependencies are downloaded and zip
    the folder (including all the modules installed by pip).  
    zip -r rookout_lambda_test.zip .

    **IMPORTANT:** If you are building on a MacOS/Windows machine, pip will compile native binaries for this platform. AWS Lambda runs on Linux and thus needs the linux compiled binaries. To build AWS Lambda compatible native extensions, simply run the following command line:
    ```
    docker run -v `pwd`:`pwd` -w `pwd` -i -t lambci/lambda:build-python2.7 pip install rook -t .
    ```
    
    You can read more about building a local native extension in our [blog](https://www.rookout.com/3_min_hack_for_building_local_native_extensions/).

    - **aws-cli** : Create a new Lambda function and update it like so :
        ```bash
        aws lambda create-function \
                    --region <REGION> \
                    --function-name rookout_lambda_test \
                    --zip-file fileb://rookout_lambda_test.zip \
                    --role <ROLE-ARN> \
                    --handler lambda_function.lambda_handler \
                    --runtime python2.7 \
                    --environment Variables="{ROOKOUT_TOKEN=<org_token>,ROOKOUT_ROOK_TAGS=lambda}" \
                    --timeout 25
      ```
        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

    - Using **Cloud9 IDE** integrated tools.

1. Set your Rookout Token as an environment variables in the Lambda configuration:
    - `ROOKOUT_TOKEN` : Your Organization Token

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing the Rookout SDK: `pip install rook -t .` (installs module in root folder)

1. Wrapping our function by using our Rookout lambda decorator as follows:
    ```python
    from rook.serverless import serverless_rook

    @serverless_rook
    def lambda_handler(event, context):
        return 'Hello World'
    ```
    
1. Setting our Rookout Token as a Lambda environment variable: `ROOKOUT_TOKEN`
    

[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
