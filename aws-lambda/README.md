# Quickstart for Node + Agentless Rookout on AWS Lambda

A sample application for using Node + Agentless Rookout on AWS Lambda

Before following this guide we recommend reading the basic [Node + Rookout] guide


## Rookout Integration Explained

There are 3 simple steps to integrate Rookout into your existing Node application for an agentless setup:

1. Add the npm dependency `rookout`

1. Wrap your lambda function with `rookout.wrap()`

1. Set the Rook's agent configuration as environment variables in the Lambda configuration


## Running on Lambda

1. Uploading your function : 
    - Zip Upload: In order to run your rookout wrapped function on Lambda, make sure the dependencies are downloaded and zip
    the folder (including node_modules).  
    zip -r rookout_test.zip .

    - aws-cli : Create a function using the hello world template named rookout-lambda-test and update it like so :
    ```bash
    $ aws lambda update-function-code --function-name rookout-lambda-test --zip-file fileb://rookout_test.zip --region {REGION}
    ```

    - **OR** Using Cloud9 IDE integrated tools
    

1. Create a lambda function on AWS, you can follow the [Amazon Documentation](https://docs.aws.amazon.com/lambda/latest/dg/get-started-create-function.html)

1. Set the Rook's agent configuration as environment variables in the Lambda configuration

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !


## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing rookout dependency : `npm install --save rookout` and adding it in the entry file `const rookout = require('rookout/lambda');`

1. Wrapping your function with the Lambda wrapper as such :  
`const rookout = require('rookout/lambda');`

```javascript
exports.handler = rookout.wrap((event, context, callback) => {
    callback(null, "Hello World");
});
```
    
1. Set Lambda environment for `ROOKOUT_AGENT_HOST` (cloud.agent.rookout.com), `ROOKOUT_AGENT_PORT` (443) and `ROOKOUT_TOKEN` in order to connect to a remote hosted agent
    

[Node + Rookout]: https://rookout.github.io/tutorials/node
