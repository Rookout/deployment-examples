# Quickstart for debugging Node.JS + AWS Lambda applications using Rookout

A sample application for debugging Node.js + AWS Lambda.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

## Rookout Integration Process

There are 3 simple steps to integrate Rookout into your existing Node application:

1. Add our lambda layer, you can find the latest version [here](https://docs.rookout.com/docs/sdk-digests.html), make sure to replace the region and version placeholder with yours  
    
    Example:
    ```bash
    aws lambda update-function-configuration --function-name YOUR-FUNCTION-NAME --layer arn:aws:lambda:us-east-1:032275105219:layer:rookout_python27_v_0_1_66_1:1
    ```

For further information check aws layers docs [here](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html)

For alternative import, install the Rookout SDK run the following command: `npm install --save rookout`

2. Wrapping your function with the Lambda wrapper as such :  

```javascript
const rookout = require('rookout/lambda');

function handler(event, context, callback) {
        callback(null, "Hello World");
}

exports.handler = rookout.wrap(handler);
```
    
3. Set Lambda environment for `ROOKOUT_TOKEN` to connect with the Rookout service.    

## Creating your function

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
                    --timeout 25
      ```
        **If you do not have access to aws-cli, you can do this from the [AWS console](https://console.aws.amazon.com/lambda/home/functions) and follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)**

1. Set your Rookout Token as an environment variable in the Lambda configuration:
    - `ROOKOUT_TOKEN` : Your Organization Token
    
    More information can be found in [our documentation](https://docs.rookout.com/docs/sdk-setup.html)
    
1. Go to [app.rookout.com](https://app.rookout.com) and start debugging!

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
