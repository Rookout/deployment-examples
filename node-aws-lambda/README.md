# Quickstart for debugging Node.JS + AWS Lambda applications using Rookout

A sample application for debugging Node.js + AWS Lambda.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

## Rookout Integration Process

There are 3 simple steps to integrate Rookout into your existing Node application:

1. Add our lambda layer, you can find the latest version [here](https://docs.rookout.com/docs/sdk-digests.html)

    You can skip this step by installing the Rookout SDK: `npm install --save rookout`
    
    If you are using MacOS/Windows check [this](#building-on-macoswindows) section.

2. Wrapping your function with the Lambda wrapper as such :  

```javascript
const rookout = require('rookout/lambda');

function handler(event, context, callback) {
        callback(null, "Hello World");
}

exports.handler = rookout.wrap(handler);
```
    
3. Set Lambda environment for `ROOKOUT_TOKEN` to connect with the Rookout service.    

## Running on Lambda

1. Uploading your function : 
    - **Zip Upload**: In order to run your Rookout-wrapped function on Lambda, make sure the dependencies are downloaded and zip
    the folder (including node_modules).  
    `zip -r rookout_lambda_test.zip .`

    - **aws-cli** : Create a new Lambda function and update it like so :
        ```bash
        aws lambda create-function \
                    --region <REGION> \
                    --function-name rookout_lambda_test \
                    --zip-file fileb://rookout_lambda_test.zip \
                    --role <ROLE-ARN> \
                    --handler index.handler \
                    --runtime nodejs8.10 \
                    --environment Variables="{ROOKOUT_TOKEN=<Your Rookout Token>,ROOKOUT_ROOK_TAGS=lambda}" \
                    --layers "LAYER-ARN" \
                    --timeout 25
      ```
        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

    - Using **Cloud9 IDE** integrated tools.
    
    #### Building on MacOS/Windows
    If you are building on a MacOS/Windows machine, npm will compile native binaries for this platform. 
    
    AWS Lambda runs on Linux and thus needs the linux compiled binaries. 
    
    To build AWS Lambda compatible native extensions, simply run the following command line (Add your node version):
    
    ```
    docker run -v `pwd`:`pwd` -w `pwd` -i -t lambci/lambda:build-nodejs<YOUR-NODE-VERSION> npm install
    ```
       
    You can read more about building a local native extension in our [blog](https://www.rookout.com/3_min_hack_for_building_local_native_extensions/).

1. Set your Rookout Token as an environment variable in the Lambda configuration:
    - `ROOKOUT_TOKEN` : Your Organization Token
    
    More information can be found in [our documentation](https://docs.rookout.com/docs/sdk-setup.html)

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging!

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
