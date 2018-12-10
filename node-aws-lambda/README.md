# Quickstart for debugging Node.JS + AWS Lambda applications using Rookout

A sample application for debugging Node.js + AWS Lambda.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Rookout Integration Explained

There are 3 simple steps to integrate Rookout into your existing Node application:

1. Add the Rookout SDK using the npm dependency `rookout`

1. Wrap your lambda function with `rookout.wrap()`

1. Set your Rookout Token as an environment variable in the Lambda configuration.

## Running on Lambda

1. Uploading your function : 
    - Zip Upload: In order to run your Rookout-wrapped function on Lambda, make sure the dependencies are downloaded and zip
    the folder (including node_modules).  
    zip -r rookout_lambda_test.zip .
    
        **IMPORTANT:** _If you are building on a MacOS/Windows machine, npm will compile native binaries for this platform. AWS Lambda runs on Linux and thus needs the linux compiled binaries. The solution is doing `npm install` or `npm rebuild` on a Linux machine such as an EC2 instance and re-archive the zip for uploading to Lambda._

    - aws-cli : Create a new Lambda function and update it like so :
        ```bash
        aws lambda create-function \
                    --region <REGION> \
                    --function-name rookout_lambda_test \
                    --zip-file fileb://rookout_lambda_test.zip \
                    --role <ROLE-ARN> \
                    --handler index.handler \
                    --runtime nodejs8.10 \
                    --environment Variables="{ROOKOUT_TOKEN=[Your Rookout Token],ROOKOUT_ROOK_TAGS=lambda}"```

        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

    - **OR** Using Cloud9 IDE integrated tools


1. Set your Rookout Token as an environment variable in the Lambda configuration:
    - `ROOKOUT_TOKEN` : Your Organization Token
    
    More information can be found in [our documentation](https://docs.rookout.com/docs/rooks-config.html)

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging!

## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing the Rookout SDK: `npm install --save rookout` and adding it in the entry file `const rookout = require('rookout/lambda');`

1. Wrapping your function with the Lambda wrapper as such :  
`const rookout = require('rookout/lambda');`

```javascript
exports.handler = rookout.wrap((event, context, callback) => {
    callback(null, "Hello World");
});
```
    
1. Set Lambda environment for `ROOKOUT_TOKEN` to connect with the Rookout service.    

[Node + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
